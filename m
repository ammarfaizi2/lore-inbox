Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUKFReB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUKFReB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUKFReB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:34:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:40064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbUKFRdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:33:51 -0500
Date: Sat, 6 Nov 2004 09:33:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Adam Heath <doogie@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <20041106120716.GA9144@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0411060922260.2223@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041106120716.GA9144@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Nov 2004, Andries Brouwer wrote:
> 
> -rw-r--r--  1 aeb users 3161708 2004-11-06 01:19 /boot/bzImage-2.6.9test
> 
> Probably I select more filesystems than you do.

Ugh, you're right. Doing a reasonably normal build without modules nets us

	  205K mm/built-in.o                                            
	  336K kernel/built-in.o                                            
	  451K sound/built-in.o                                            
	  864K net/built-in.o                                            
	 1016K fs/built-in.o                                            
	  2.3M drivers/built-in.o                                            

which is kind of scary. Of course, in the drivers, about half a meg of
that is just the PCI name translation, so some of it is trivial (and
thrown away at boot), but most of it is just spread out in fat all over. 

It's hard to go on a diet.

		Linus
