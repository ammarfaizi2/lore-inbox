Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbRFMKZM>; Wed, 13 Jun 2001 06:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbRFMKZD>; Wed, 13 Jun 2001 06:25:03 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:7950 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S262903AbRFMKYu>;
	Wed, 13 Jun 2001 06:24:50 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
In-Reply-To: <Pine.LNX.4.31.0106121549130.4477-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0106121549130.4477-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15A7os-0003e9-00@come.alcove-fr>
From: Stelian Pop <stelian@alcove.fr>
Date: Wed, 13 Jun 2001 12:24:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got just the YUV code from Gatos, and a few months ago it took less than
> an hour to merge just that part (and most of that was compiling and
> testing).

Me too. After some days playing with it it seems that the Rage Mobility
Card (from the Vaio Picturebook C1VE <- that's where we started the
discussion):
	- has almost no acceleration in XFree, including the 4.1.0 release
	- has Xv YUV->RGB acceleration in Gatos (but that's all, no direct
	  video input etc).

> The rest of Gatos is obviously more experimental, but the YUV code looks
> quite sane.

Well, not quite... I've had several X lockups while using the YUV 
acceleration code. Let's say one lockup per half an hour.

Even the performances are controversial: with 320x240, I achieve 
great performance with xawtv/meye driver, I can even use the hardware
scaling facilities (well, the xawtv sources need a little hacking for
that), but in 640x480 the framerate achieved with Xv is below the
one I get by converting YUV->RGB in software...

But the main question remains: does the MotionEye camera support
overlay or not ? It could be that it is connected to the feature
connector of the ATI board for doing direct video input/output
(but no X driver recognizes this connector today). The motion jpeg
chip this camera is based on definately has a video output.

Or it could just be the application who gets YUV data from the chip
then send it directly to the video board. Today this works, almost
(because we need a patched X - read gatos - and a patched xawtv - in
order to do scaling).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
