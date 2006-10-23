Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWJWLht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWJWLht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWJWLht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:37:49 -0400
Received: from as1.cineca.com ([130.186.84.251]:6016 "EHLO as1.cineca.com")
	by vger.kernel.org with ESMTP id S932073AbWJWLhs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:37:48 -0400
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: teunis <teunis@wintersgift.com>
Subject: Re: sn9c10x list corruption in 2.6.18.1
Date: Mon, 23 Oct 2006 13:37:47 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061022031145.GA24855@redhat.com> <200610222322.46703.luca.risolia@studio.unibo.it> <453C2A57.2030305@wintersgift.com>
In-Reply-To: <453C2A57.2030305@wintersgift.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610231337.48203.luca.risolia@studio.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 04:35, lunedì 23 ottobre 2006, teunis ha scritto:
> Luca Risolia wrote:
> > Alle 20:15, domenica 22 ottobre 2006, Dave Jones ha scritto:
> >> But it only happens when the user unplugs the camera, and no other
> >> webcam driver seems to be affected by this problem.
> >
> > Simply unplugging the camera does not reproduce any problem here. This is
> > the first time I see this bug.
> >
> >> That's fairly conclusive to me that the driver is misbehaving.
> >
> > I do not think this implication is correct, as not all the drivers are
> > implemented the same way and run under the same kernel configurations.
> >
> > The code in the driver seems to be okay to me.
> >
> 
> I've seen crashes (rock solid - system halted, following a core dump)
> occasionally when unplugging this device:

Could you test the version I maintain out of the tree?
http://www.linux-projects.org/modules/mydownloads/visit.php?cid=2&lid=44

I see the driver has been patched in the latest kernels and I didn't have
the time to review and test the new code.

Best regards
Luca


> sn9c102: V4L2 driver for SN9C10x PC Camera Controllers v1:1.27
> usb 2-1: SN9C10[12] PC Camera Controller detected (vid/pid 0x0C45/0x6005)
> usb 2-1: TAS5110C1B image sensor detected
> usb 2-1: Initialization succeeded
> usb 2-1: V4L2 device registered as /dev/video0
> usbcore: registered new interface driver sn9c102
> 
> It crashed 100% with 2.6.19-rc1-git6.  2.6.19-rc2-mm2: it only crashes
> occasionally (1/10 times) making me suspect a lock issue.   Haven't the
> foggiest where to look and as I only tested this hardware on a whim,
> it's not high enough priority for me to debug.   I'm also so rusty on
> drivers that my eyes would probably be of no help.
> 
> I can duplicate this on several different systems - but they're all
> EHCI-based USB2 hosts.  (Intel Corporation 82801DB/DBM on this laptop)
> Maybe that helps.
> 
> - Teunis
> 
> 
