Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTEMSry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTEMSrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:47:53 -0400
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:44503 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id S263285AbTEMSrg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:47:36 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Date: Tue, 13 May 2003 14:00:14 -0500
Message-ID: <B578DAA4FD40684793C953B491D4879174D3BA@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Thread-Index: AcMZgRFxFY/CRjQBRoyEBiwqeZDfQAAAJOLA
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "David Howells" <dhowells@warthog.cambridge.redhat.com>,
       "Jan Harkes" <jaharkes@cs.cmu.edu>
Cc: "David Howells" <dhowells@cambridge.redhat.com>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  (2) gettok(const char *fs, const char *key, size_t size, 
> void *buffer)
> > > 
> > >      Get a copy of an authentication token.
> > 
> > Not sure what the use of this is for userspace. I can see how your
> > kernel module would use it.
> 
> OpenAFS has it, but I'm not sure what uses it.

Any afs user space tool that needs to talk to file servers - such as all
the administration utilities - vos, bos, pts, etc. Eventually they could
use kerberos cred caches directly, but not until they are converted to
kerberos. Right now, they fetch the current auth data from the kernel
and use it to authenticate to whatever non-kernel service they are
talking to.

-- Nathan
