Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbQLRGrU>; Mon, 18 Dec 2000 01:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbQLRGrK>; Mon, 18 Dec 2000 01:47:10 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6410 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129557AbQLRGrE>; Mon, 18 Dec 2000 01:47:04 -0500
Date: Mon, 18 Dec 2000 00:16:34 -0600
To: khromy <khromy@lnuxlab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols pm_*register ad1848.o
Message-ID: <20001218001634.A3199@cadcamlab.org>
In-Reply-To: <20001217220851.A37686@lnuxlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217220851.A37686@lnuxlab.net>; from khromy@lnuxlab.net on Sun, Dec 17, 2000 at 10:08:51PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[khromy]
> 2.4.0-test13-pre3 unresolved symbols:
> 
> modprobe ad1848
> /lib/modules/2.4.0-test13-pre3/kernel/drivers/sound/ad1848.o: unresolved symbol pm_unregister_Reccd1e64
> /lib/modules/2.4.0-test13-pre3/kernel/drivers/sound/ad1848.o: unresolved symbol pm_register_R8dbab11c

Looks like your symbol versions got out of sync, somehow.
Unfortunately this is fairly easy to do, due to the fragile nature of
MODVERSIONS.

  cp .config ..
  make mrproper
  cp ../.config .
  make oldconfig
  make dep

and try again.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
