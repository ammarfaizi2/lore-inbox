Return-Path: <linux-kernel-owner+w=401wt.eu-S1751023AbXADTaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXADTaj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbXADTaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:30:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46491 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbXADTai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:30:38 -0500
Date: Thu, 4 Jan 2007 11:30:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
In-Reply-To: <20070104191451.GW17561@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org>
 <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org>
 <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org>
 <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Al Viro wrote:
> 
> How about "makes call graph analysis easier"? ;-)  In principle, I have
> no problem with force-casting, but it'd better be cast to the right
> type...

Do we really care in the kernel? We simply never use function pointer 
casts like this for anything non-trivial, so if the graph analysis just 
doesn't work for those cases, do we really even care?

The only case I can _remember_ us doing this for is literally the 
error-returning functions, where the call graph finding them really 
doesn't matter, I think.

So I don't _object_ to that reason, I just wonder whether it's really a 
big issue..

			Linus
