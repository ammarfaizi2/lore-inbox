Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVCUWLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVCUWLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVCUWLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:11:00 -0500
Received: from smtp1.sloane.cz ([62.240.161.228]:27121 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S261930AbVCUWKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:10:45 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] potential pitfall? changing configuration while PC in hibernate (fwd)
Date: Mon, 21 Mar 2005 23:10:37 +0100
User-Agent: KMail/1.7.1
References: <20050321184512.GA1390@elf.ucw.cz>
In-Reply-To: <20050321184512.GA1390@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503212310.37801.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is real stupid, that Linux kernel freezes when simply during hibernate I 
change Bluetooth dongle to USB mouse in my USB port.

And it is not uncommon problem - I have BT dongle that starts in HID proxy 
mode and then I switch it to HCI mode. So I hibernate with BT dongle and 
after hibernate Linux only reads image from Swap and then freezes! :( Problem 
is, that It delete image from swap imeditially after reading it, so when I 
tried is simply with USB mouse (hibernate without it and plug it when 
notebook was switched off) it doesn't read it from swap ever and I lost all 
my memory :(

I can do nothing with this behavior of my dongle and there is no known way how 
to switch it back to HID-proxy mode before hibernate (Marcel correct me if I 
am wrong) - CSR based dongle D-Link with Apple firmware.

Windows knows it and doesn't have problem with it for 5 years! :)

Laptop is all Intel based, kernel 2.6.11.5-vanilla, gcc 3.4.3, Debian testing

Michal


> ----- Forwarded message from David Brownell <david-b@pacbell.net> -----
>
> X-Original-To: pavel@atrey.karlin.mff.cuni.cz
> To: linux-pm@lists.osdl.org
> Subject: Re: [linux-pm] potential pitfall? changing configuration while PC
> in hibernate Cc: Pavel Machek <pavel@ucw.cz>, Arioch <the_Arioch@nm.ru>
> X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on
>  atrey.karlin.mff.cuni.cz
> X-Spam-Level: *
> X-Spam-Status: No, score=1.8 required=5.0 tests=DNS_FROM_RFC_ABUSE,
>  DNS_FROM_RFC_POST autolearn=no version=3.0.2
> X-CRM114-Status: Good  ( pR: 18.5243 )
>
> On Monday 21 March 2005 1:52 am, Pavel Machek wrote:
> > On Po 21-03-05 11:02:04, Arioch wrote:
> > > I wonder, if hardware configuration asked for changes when resuming
> > > from hibernate ?
> >
> > Current position is "don't do this". You *will* be able to recover by
> > passing noresume, but if you change hw configuration, it may crash&burn.
>
> That may be Pavel's position, but USB-wise we absolutely consider
> it a bug if Linux misbehaves in the face of routine actions like
> unplugging a device during suspend (or plugging in a new one).
> Regardless of "noresume" etc.
>
> I'd say that's true for all hotpluggable busses, in fact, but I
> rarely submit patches for non-USB ones like PCMCIA or CardBus.
>
> - Dave
>
>
> ----- End forwarded message -----

-- 
S pozdravem

Michal Semler
