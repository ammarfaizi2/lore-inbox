Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbTEMRfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTEMRfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:35:41 -0400
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:18317 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id S262334AbTEMRfj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:35:39 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Date: Tue, 13 May 2003 12:48:22 -0500
Message-ID: <B578DAA4FD40684793C953B491D4879174D3B6@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Thread-Index: AcMZdx5fXbxsi2BIR+id222V94K2hwAAFyRw
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "David Howells" <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Also, using a separate PAG structure means that you can 
> lend your keys to
> > > an SUID program and conversely it means a SUID program 
> can't so easily
> > > gain access to keys it didn't inherit from its caller.
> > 
> > "task->user" always follows uid ("real uid"), and as such 
> you can always
> > switch back and forth by just changing uid.
> 
> So anyone who has the ability to get root on a box can 
> immediately use other
> peoples keys with su... OTOH, the ability to get root would 
> normally permit
> someone sufficiently motivated to get this anyway.

This isn't any good since it implies that a given uid can only have a
single set of tokens. Users can freely authenticate to afs and get
tokens for other afs ids at any time. As long as they are in different
pags, they can freely coexist. Now, if you're talking about pag-less
only, then the above is reasonable and expected. 

-- Nathan
