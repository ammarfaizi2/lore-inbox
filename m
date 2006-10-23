Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWJWCfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWJWCfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 22:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWJWCfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 22:35:42 -0400
Received: from webserve.ca ([69.90.47.180]:59612 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S1751214AbWJWCfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 22:35:40 -0400
Message-ID: <453C2A57.2030305@wintersgift.com>
Date: Sun, 22 Oct 2006 19:35:03 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Luca Risolia <luca.risolia@studio.unibo.it>, linux-kernel@vger.kernel.org
Subject: Re: sn9c10x list corruption in 2.6.18.1
References: <20061022031145.GA24855@redhat.com> <200610221346.53038.luca.risolia@studio.unibo.it> <20061022181539.GD27152@redhat.com> <200610222322.46703.luca.risolia@studio.unibo.it>
In-Reply-To: <200610222322.46703.luca.risolia@studio.unibo.it>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Luca Risolia wrote:
> Alle 20:15, domenica 22 ottobre 2006, Dave Jones ha scritto:
>> But it only happens when the user unplugs the camera, and no other
>> webcam driver seems to be affected by this problem.
> 
> Simply unplugging the camera does not reproduce any problem here. This is
> the first time I see this bug.
> 
>> That's fairly conclusive to me that the driver is misbehaving.
> 
> I do not think this implication is correct, as not all the drivers are
> implemented the same way and run under the same kernel configurations.
> 
> The code in the driver seems to be okay to me.
> 

I've seen crashes (rock solid - system halted, following a core dump)
occasionally when unplugging this device:
sn9c102: V4L2 driver for SN9C10x PC Camera Controllers v1:1.27
usb 2-1: SN9C10[12] PC Camera Controller detected (vid/pid 0x0C45/0x6005)
usb 2-1: TAS5110C1B image sensor detected
usb 2-1: Initialization succeeded
usb 2-1: V4L2 device registered as /dev/video0
usbcore: registered new interface driver sn9c102

It crashed 100% with 2.6.19-rc1-git6.  2.6.19-rc2-mm2: it only crashes
occasionally (1/10 times) making me suspect a lock issue.   Haven't the
foggiest where to look and as I only tested this hardware on a whim,
it's not high enough priority for me to debug.   I'm also so rusty on
drivers that my eyes would probably be of no help.

I can duplicate this on several different systems - but they're all
EHCI-based USB2 hosts.  (Intel Corporation 82801DB/DBM on this laptop)
Maybe that helps.

- - Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPCpPbFT/SAfwLKMRAu/SAJ9p2pEAZST1b0aI1Pbphp5UF0MgGwCdH3sh
3o7bNGOUXos6A/HjI0izn9U=
=9Fn7
-----END PGP SIGNATURE-----
