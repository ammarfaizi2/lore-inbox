Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbTH0P1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTH0P1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:27:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:39383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263442AbTH0P1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:27:41 -0400
Date: Wed, 27 Aug 2003 08:22:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help with debugging of a framebuffer driver on a legacyfree
 system.
Message-Id: <20030827082238.0508aa9e.rddunlap@osdl.org>
In-Reply-To: <20030827142035.GA25937@zensonic.dk>
References: <20030827142035.GA25937@zensonic.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 16:20:35 +0200 "Thomas S. Iversen" <zensonic@zensonic.dk> wrote:

| Hi there 
| 
| As part of a project I am trying to write a framebuffer device
| driver for a graphic chip. Up until now I have compiled my
| code as a module and been doing insmod, rmmod and that have worked
| nicely.
| 
| I then tried to compile the driver into the kernel but that
| makes the kernel hang. As my development system are a legacy
| free laptop and my driver initializes the screen, the kernel
| hangs without me being able to figure out where and why that
| happend.

First choice would be to develop on a system where you can add
(PCI?) bus probes or other adapters/gadgets, like a port-80 card.

| So I seek advice on how to debug the driver! As said, the
| laptop are legacy free, so I have not got a serial port. 
| I have tried a usb->serial adapter, but that requires a driver.
| Can I do USB->USB on another computer? Or?
| 
| Or am I stuck with coding my own printk variant and writing to the
| screen or is there any other option I have not thought of?

There are already early_printk patches and an x86-specific
"poke a character into video RAM" patch.  The latter one is at:
  http://kernelnewbies.org/documents/videochar.txt

--
~Randy
