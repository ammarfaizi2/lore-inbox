Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUHaTqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUHaTqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269072AbUHaTqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:46:39 -0400
Received: from mini.brewt.org ([64.180.111.212]:58378 "HELO mini.brewt.org")
	by vger.kernel.org with SMTP id S268965AbUHaToU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:44:20 -0400
Date: Tue, 31 Aug 2004 12:44:08 -0700
From: "Adrian Yee" <brewt-linux-kernel@brewt.org>
Subject: Re: HDD LED doesn't light.
To: Eric Mudama <edmudama@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <GMail.1093981448.21536945.017857081112@brewt.org>
In-Reply-To: <311601c904082709107a8c8475@mail.gmail.com>
Mime-Version: 1.0
References: <311601c904082709107a8c8475@mail.gmail.com>
X-Gmail-Account: brewt@brewt.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just an FYI... historically, the LED has been driven in PATA with a
> signal known as /DASP, this is an active-low signal called "Drive
> Active / Slave Present" and a PATA drive asserts this signal when
> processing a command.
> 
> If I understand it right, in SATA, instead of a wire-based protocol,
> we have a serialized packet-based protocol, so there was no driving
> of
> an LED in the initial specification.  Revisions to the specification
> have since commandeered one of the pins on the power connector for
> use
> as a /DASP signal to drive an LED.  However, to do that you
> obviously
> can't be using a MOLEX->SATA power adapter, you need a motherboard
> that natively supports SATA.  The 3112 you mention attempts to be a
> native SATA solution, it doesn't act merely as a PATA->SATA
> converter.
>  Therefore, they may not have done the DASP- signal internally.

But this doesn't explain why I have two motherboards here where the HDD
activity LED does not light up in linux (for SATA drives) but does in
windows .  Note that it only starts working in windows *after* the
driver has loaded.  One is an ASUS A7N8X Deluxe (rev 1.0) and the other
an Abit NF7-S (rev 2.0), both with Sil3112 controllers.  On the other
hand, I have a DFI Ultra Infinity with a Sil3114 whose activity LED
works fine in linux.

Adrian
