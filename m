Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131416AbQLKAki>; Sun, 10 Dec 2000 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132680AbQLKAk2>; Sun, 10 Dec 2000 19:40:28 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:60420 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131416AbQLKAkK>; Sun, 10 Dec 2000 19:40:10 -0500
Message-ID: <3A341B3F.B5D962A8@Hell.WH8.TU-Dresden.De>
Date: Mon, 11 Dec 2000 01:09:35 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Ion Badulescu <ionut@cs.columbia.edu>,
        Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <3A3143D5.98E8E948@Hell.WH8.TU-Dresden.De> <5.0.2.1.2.20001210232808.04affbd0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anton Altaparmakov wrote:

> Just to say that the patch (including added 4) fixed the "card reports no
> resources" messages for me. - Looking at my logs the messages appeared once
> every 10-40 minutes. - Now the box is up for more than 5 hours with the
> patch and test12-pre7 and not a single no resources message logged so far.
> (Note, I upgraded the kernel at the same time as adding the patch so it is
> actually possible that test12-pre7 vanilla is fixed as well.)

The problem here only ever happens at initialisation/first packets. Once the
network interface has been initialised properly it never produces those
messages anymore. Usually it helps to shut the NIC down with ifconfig and
bringing it back up afterwards to properly initialise it.

If you are bored, try to reboot a couple dozen times and see if you still
see it. I have test12-pre7 also.

> My card is an Ether Express Pro 100, lcpci says: Intel Corporation 82557
> [Ethernet Pro 100] (rev 04) and lspci -n gives: class 0200: 10b7:9004

Mine's a rev 08.

00:0d.0 Class 0200: 8086:1229 (rev 08)

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
