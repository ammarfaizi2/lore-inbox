Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281205AbRKLB4y>; Sun, 11 Nov 2001 20:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281212AbRKLB4p>; Sun, 11 Nov 2001 20:56:45 -0500
Received: from zok.SGI.COM ([204.94.215.101]:23517 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281205AbRKLB4l>;
	Sun, 11 Nov 2001 20:56:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Thomas Hood <jdthood@home.dhs.org>, linux-kernel@vger.kernel.org,
        jdthood@mail.com
Subject: Re: [PATCH] parport_pc to use pnpbios_register_driver() 
In-Reply-To: Your message of "Sun, 11 Nov 2001 21:42:34 BST."
             <Pine.LNX.4.33.0111112134430.1518-100000@vaio> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Nov 2001 12:56:29 +1100
Message-ID: <32053.1005530189@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001 21:42:34 +0100 (CET), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>linux/isapnp.h has the following code:
>
>---
>#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
> 
>#define __ISAPNP__
>---
>
>I believe the pnpbios driver should do things something similar. Users of 
>the interface should then only check for #ifdef __PNPBIOS__.
>
>The reasoning behind this is the following: When you have a driver 
>built-in, but pnpbios modular, the driver cannot use pnpbios 
>functionality. The above definition reflects exactly this.

Does this combination make sense?  If you are building a pnpbios driver
into the kernel then the configuration should force pnpbios support to
be built in as well.  We don't allow this combination for things like
scsi or ide, they require the common support to be built in if any
drivers are built in.  IMHO this problem should be fixed in .config,
not in driver source.

