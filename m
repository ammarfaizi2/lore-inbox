Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130649AbQKNGEn>; Tue, 14 Nov 2000 01:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130668AbQKNGEe>; Tue, 14 Nov 2000 01:04:34 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:54031 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130649AbQKNGEO>; Tue, 14 Nov 2000 01:04:14 -0500
Date: Mon, 13 Nov 2000 23:33:57 -0600
To: LA Walsh <law@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE0 /dev/hda performance hit in 2217 on my HW
Message-ID: <20001113233357.H18203@wire.cadcamlab.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIEJDCJAA.law@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIEJDCJAA.law@sgi.com>; from law@sgi.com on Mon, Nov 13, 2000 at 01:52:37PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Linda Walsh]
> Under 2217, the xfer speed drops to near 1,000K/s.  This is for both
> 'badblocks'
> and a 'dd' if=/dev/hda of=/dev/hdb bs=256k.  In both instances, I notice
> a near 90% performance degredation.

Off the top of my head it sounds like you are using the wrong ide i/o
mode.  Your hardware probably supports UDMA66 but you are getting one
of the old PIO modes by default.  What chipset does the Inspiron 7500
use?  (Probably Intel something.  Dell loves Intel.)

A short session with 'hdparm' will confirm or refute this theory.

Andre Hedrick's IDE patch reportedly does a much better job of
supporting and auto-configuring modern chipsets than vanilla 2.2.

  http://www.??.kernel.org/pub/linux/kernel/people/hedrick/

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
