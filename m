Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270483AbTGSCyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 22:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTGSCyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 22:54:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:28387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270483AbTGSCyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 22:54:33 -0400
Date: Fri, 18 Jul 2003 20:09:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] General filesystem cache
In-Reply-To: <23055.1058538289@warthog.warthog>
Message-ID: <Pine.LNX.4.44.0307182000300.6370-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Jul 2003, David Howells wrote:
> 
> Here's a patch to add a quasi-filesystem ("CacheFS") that turns a block device
> into a general cache for any other filesystem that cares to make use of its
> facilities.
> 
> This is primarily intended for use with my AFS filesystem, but I've designed
> it such that it needs to know nothing about the filesystem it's backing, and
> so it may also be useful for NFS, SMB and ISO9660 for example.

Ok. Sounds good. In fact, it's something I've wanted for a while, since 
it's also potentially the solution to performance-critical things like 
virtual filesystems based on revision control logic etc (traditionally 
done with fake NFS servers).

I did a very very quick scan, and didn't see anything that raised my 
hackles. But it's late in the 2.6.x game, and as a result I'm not going to 
apply it until I get a lot of feedback from actual users too.

		Linus

