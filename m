Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTKOVS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 16:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTKOVS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 16:18:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:31239 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S262069AbTKOVSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 16:18:25 -0500
Date: Sat, 15 Nov 2003 22:18:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre5 bugs: depmod and Unresolved symbols
Message-ID: <20031115211818.GD9634@alpha.home.local>
References: <3FB57AE7.5000706@wanadoo.es> <Pine.LNX.4.44.0311151428080.10014-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311151428080.10014-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 15, 2003 at 02:29:16PM -0200, Marcelo Tosatti wrote:
> 
> On Sat, 15 Nov 2003, Xose Vazquez Perez wrote:
> > http://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa3/00_comx-driver-compile-1
> > 
> > 00_comx-driver-compile-1 first appeared in 2.4.19pre8aa2 - 258 bytes
> > 
> > 	Export proc_get_inode for kernel/drivers/net/wan/comx.o so
> > 	it can link as a module, noticed by Eyal Lebedinsky.
> 
> I just applied this and Jeff Garzik pointed out that its wrong to export
> proc_get_inode, and that comx should be fixed instead.
> 
> I reverted the change. 

Christoph Hellwig once explained us why it was bad and basically what needed
to be done in comx to make it link. But I think that nobody uses this driver
nowadays or that its users blindly apply this patch. I myself once tried to
fix it because of this annoyance (although I don't use it), and found myself
duplicating lots of proc stuff so I concluded this was plain silly and that
the comx driver will simply be disabled in my later kernels.

Cheers,
Willy

