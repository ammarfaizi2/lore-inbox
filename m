Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTKOQin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTKOQin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 11:38:43 -0500
Received: from intra.cyclades.com ([64.186.161.6]:26834 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261812AbTKOQim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 11:38:42 -0500
Date: Sat, 15 Nov 2003 14:29:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.23-pre5 bugs: depmod and Unresolved symbols
In-Reply-To: <3FB57AE7.5000706@wanadoo.es>
Message-ID: <Pine.LNX.4.44.0311151428080.10014-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Nov 2003, Xose Vazquez Perez wrote:

> Xose Vazquez Perez wrote:
> 
> > depmod: *** Unresolved symbols in /lib/modules/2.4.23-pre5/kernel/drivers/net/wan/comx.o
> > depmod:         proc_get_inode
> 
> This bug was fixed in aa since 2.4.19pre8aa2 !!
> Maybe someone needs to do a sync between 2.4.24-pre1 against pac and aa patches.
> 
> http://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa3/00_comx-driver-compile-1
> 
> 00_comx-driver-compile-1 first appeared in 2.4.19pre8aa2 - 258 bytes
> 
> 	Export proc_get_inode for kernel/drivers/net/wan/comx.o so
> 	it can link as a module, noticed by Eyal Lebedinsky.

I just applied this and Jeff Garzik pointed out that its wrong to export
proc_get_inode, and that comx should be fixed instead.

I reverted the change. 


