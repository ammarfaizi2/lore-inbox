Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267100AbTGLBIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 21:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267044AbTGLBIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 21:08:52 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:1431 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S267100AbTGLBIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 21:08:51 -0400
Date: Sat, 12 Jul 2003 02:14:53 +0100 (BST)
From: Jon Masters <jonathan@jonmasters.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
cc: Jon Masters <jonathan@jonmasters.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, jcm@printk.net
Subject: Re: Stripped binary insertion with the GNU Linker suggestions (fwd)
In-Reply-To: <EE71A277-B3BD-11D7-B05B-000A95A0560C@us.ibm.com>
Message-ID: <Pine.LNX.4.10.10307120212280.25244-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Hollis Blanchard wrote:

> Not sure I understand the problem exactly, but I believe ppc32 kernels 
> do exactly what you want. Have a look at arch/ppc/boot/ld.script and 
> see __{image,ramdisk,sysmap}_begin . Also see how e.g. 
> arch/ppc/boot/prep/Makefile uses objcopy 
> --add-section=.image=vmlinux.gz .

I had another look at this tonight on the train and agree that this was
after all exactly what I want and I will need to use this "dummy" method
to force the kernel in to a single section before shoving it in to the
final ELF output image.

Jon.

