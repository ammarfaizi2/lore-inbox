Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWCJAtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWCJAtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWCJAtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:49:52 -0500
Received: from hera.kernel.org ([140.211.167.34]:61659 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932174AbWCJAtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:49:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Thu, 9 Mar 2006 16:49:01 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <duqidt$erm$1@terminus.zytor.com>
References: <17422.19209.60360.178668@cargo.ozlabs.ibm.com> <31492.1141753245@warthog.cambridge.redhat.com> <28393.1141823992@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1141951741 15233 127.0.0.1 (10 Mar 2006 00:49:01 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 10 Mar 2006 00:49:01 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <28393.1141823992@warthog.cambridge.redhat.com>
By author:    David Howells <dhowells@redhat.com>
In newsgroup: linux.dev.kernel
> 
> However, on i386, for example, you've actually got at least two different I/O
> access domains, and I don't know how they impinge upon each other (IN/OUT vs
> MOV).
> 

You do, but those aren't the ones.

What you have is instead MOVNT versus everything else.  IN/OUT are
total sledgehammers, as they imply not only nonposted operation, but
the instruction implies wait for completion; this is required since
IN/OUT support emulation via SMI.

	-hpa
