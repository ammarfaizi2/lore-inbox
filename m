Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263156AbTCTAUY>; Wed, 19 Mar 2003 19:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263164AbTCTAUY>; Wed, 19 Mar 2003 19:20:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9867
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263156AbTCTAUW>; Wed, 19 Mar 2003 19:20:22 -0500
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared
	IRQs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wolfram Schlich <lists@schlich.org>
Cc: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org>
References: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048124539.647.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Mar 2003 01:42:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 22:16, Wolfram Schlich wrote:
> When one of the Promise controllers is sharing the same IRQ with one of
> the NICs (don't matter which, I tried all) and data is copied *to* the
> machine over the network, the system deadlocks. When data is copied
> *from* the system over the network, it works all ok. Unfortunately the
> system BIOS doesn't give me any possibility of setting the IRQ
> channels by hand, so all I can do is put the cards into other slots.
> 

Thats very useful information. There certain have been (and it seems
still are) some cases with shared IRQ that are not quite handled right.
The 2.4.21pre5/pre5-ac work has partly been about fixing it. Deadlocks
suprise me however, since the problems I've seen have been I/O
errors.

However there is another known problem that does cause deadlocks with
the AMD76x, especially if the onboard IDE is used. Shove a PS/2 mouse
in the box, reboot and retest - if you dont already have one

