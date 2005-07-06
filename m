Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVGGC00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVGGC00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVGFT7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262191AbVGFQWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:22:20 -0400
Date: Wed, 6 Jul 2005 09:22:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2
In-Reply-To: <20050706155103.GA13115@kroah.com>
Message-ID: <Pine.LNX.4.58.0507060917530.3570@g5.osdl.org>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
 <42CBA650.8080004@eyal.emu.id.au> <Pine.LNX.4.58.0507060837510.3570@g5.osdl.org>
 <20050706155103.GA13115@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Greg KH wrote:
> 
> --- gregkh-2.6.orig/sound/pci/bt87x.c	2005-07-06 08:48:29.000000000 -0700
> +++ gregkh-2.6/sound/pci/bt87x.c	2005-07-06 08:48:54.000000000 -0700
> @@ -798,6 +798,8 @@
>  	{0x270f, 0xfc00}, /* Chaintech Digitop DST-1000 DVB-S */
>  };
>  
> +static struct pci_driver driver;
> +

Hmm.. Shouldn't you at a _minimum_ initialize the name and owner fields?

		Linus
