Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRJ2BTa>; Sun, 28 Oct 2001 20:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278937AbRJ2BTU>; Sun, 28 Oct 2001 20:19:20 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:33285 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S278932AbRJ2BTN>;
	Sun, 28 Oct 2001 20:19:13 -0500
Message-Id: <5.1.0.14.0.20011029112004.01d98df0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Oct 2001 12:19:45 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS/Trident 4DWave sound driver (Update)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E15x86H-0000GV-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.0.20011026125325.024517e0@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:36 PM 26/10/01 +0100, Alan Cox wrote:
> > though the codec->codec_read(codec, AC97_VENDOR_ID#) isn't returning the
> > codec value for this system at all.
>
>Something is failing to bring up the AC97 codec bus and/or set it up
>properly. Can you find exactly which patch broke that for you (you'll
>possibly want to keep fixing the codec table as you test older ones)

Update: - 2.4.3 appears to have the same issue of no-find the codec.

2.2.19pre17 reports the wrong h/ware address for the sound device (the same 
one as the IDE bus - urghy!), so I can't even load the driver to test if 
it'll work (which I doubt).

Upon looking at the code between 2.4.0 and 2.4.13, in particular at 
trident_ac97_get() and trident_ac97_set() there is practically no 
difference between them, except for the addition of another option in the 
switch statement for another card. Almost all the additions and changes 
between versions have been specifically ALi or similar chipsets, and don't 
seem to affect the SiS stuff.

So where to now?

Thinking mebbe I should hook this machine up to the net outside the 
firewall, plug in the webcam and point it at it, give you an ssh account on 
it, and connect an oscilloscope to the audio and let you fiddle. Useful for 
the SiS FrameBuffer thing as well I'd guess. *grin*

Talk about remote debugging eh?


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

