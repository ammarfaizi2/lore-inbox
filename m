Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUAGDkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 22:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUAGDkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 22:40:45 -0500
Received: from dp.samba.org ([66.70.73.150]:54719 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266128AbUAGDko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 22:40:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Ville Herva <vherva@twilight.cs.hut.fi>
Cc: xavier.bestel@free.fr, linux-kernel@vger.kernel.org
Subject: Re: floppy driver and multiple floppies (was Re: 2.6.0 under vmware ?) 
In-reply-to: Your message of "Mon, 05 Jan 2004 18:14:31 BST."
             <20040105171431.GA1776@vana.vc.cvut.cz> 
Date: Wed, 07 Jan 2004 14:21:29 +1100
Message-Id: <20040107034042.5942D2C066@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040105171431.GA1776@vana.vc.cvut.cz> you write:
> -MODULE_PARM(floppy,"s");
> -MODULE_PARM(FLOPPY_IRQ,"i");
> -MODULE_PARM(FLOPPY_DMA,"i");
> +module_param(floppy, charp, 0);
> +module_param(FLOPPY_IRQ, int, 0);
> +module_param(FLOPPY_DMA, int, 0);

You really don't want these to be visible through sysfs?  I'd expect
0444 rather than 0 as the last arg...

Also it'd be nice to do furthur cleanups and get rid of the #ifdef
MODULE altogether...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
