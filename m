Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbTCRJ5a>; Tue, 18 Mar 2003 04:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbTCRJ5a>; Tue, 18 Mar 2003 04:57:30 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:22788 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262428AbTCRJ53>; Tue, 18 Mar 2003 04:57:29 -0500
Date: Tue, 18 Mar 2003 11:08:08 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: CaT <cat@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65
In-Reply-To: <20030318052257.GB635@zip.com.au>
Message-ID: <Pine.LNX.4.44.0303181040150.12110-100000@serv>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
 <20030318052257.GB635@zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Mar 2003, CaT wrote:

> One question. Should PCMCIA_AHA152X only be compilable as a module? I
> found this in Kconfig:
> 
> config PCMCIA_AHA152X
>         tristate "Adaptec AHA152X PCMCIA support"
>         depends on m
>         help
>           Say Y here if you intend to attach this type of PCMCIA SCSI host
>           adapter to your computer.
> 	  ...
> 
> The help and the tristate seems to indicate that I should be able to
> compile it into the kernel, but menuconfig wont let me. This is
> presumably due to the dependancy but is it right?

Yes, this was the behaviour of the old config tools, which was restored 
with 2.5.65. This means 'm' is a marker that this thing works only as a 
module.
If you want the other behaviour, that it can only be built as a module in 
a modular kernel, but compile it into a nonmodular kernel, you can use "m 
|| !MODULES" instead.

bye, Roman

