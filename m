Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbUALKIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUALKIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:08:14 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:22912 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S266107AbUALKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:08:04 -0500
Date: Mon, 12 Jan 2004 11:07:46 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: joshk@triplehelix.org
Subject: Re: [PATCH] ALSA 1.0.1
Message-ID: <20040112100746.GC2169@charite.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	joshk@triplehelix.org
References: <Pine.LNX.4.58.0401082059300.13704@pnote.perex-int.cz> <20040109101759.GC12107@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040109101759.GC12107@triplehelix.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joshua Kwan <joshk@triplehelix.org>:

> I've tried this code with 2.6.1-mm1 and it results in my speakers
> emitting a small high pitched noise when it's not busy playing audio,
> using the intel8x0 driver. I'm using the onboard sound on my nForce2
> based motherboard, here is the information in dmesg (not a lot,
> admittedly) when i load the driver:
> 
> intel8x0_measure_ac97_clock: measured 49457 usecs
> intel8x0: clocking to 47478
> 
> Otherwise it still seems to work OK.

It seems to work here. I found that the new ALSA drivers change or
activate new mixer options, thus causing background noise. Once I
fixed the mixer values, all was well.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
