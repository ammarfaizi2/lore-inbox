Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLRH2S>; Mon, 18 Dec 2000 02:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLRH2J>; Mon, 18 Dec 2000 02:28:09 -0500
Received: from pop.gmx.net ([194.221.183.20]:47316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129340AbQLRH1s>;
	Mon, 18 Dec 2000 02:27:48 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Mon, 18 Dec 2000 07:54:33 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: f5ibh <f5ibh@db0bm.ampr.org>, linux-kernel@vger.kernel.org
To: Keith Owens <kaos@ocs.com.au>, nbreun@gmx.de
In-Reply-To: <1408.977041939@ocs3.ocs-net>
In-Reply-To: <1408.977041939@ocs3.ocs-net>
Subject: Re: 2.4.0-test13-pre2, unresolved symbols
MIME-Version: 1.0
Message-Id: <00121807453300.00788@nmb>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

thanks for your hint. The problem seems that all modules (+ directory 
~/media) under /lib/modules/2.4.0-test13pre3/kernel/drivers/media/  are 
missing. Make modules_install does not build the directory ~/media and its 
contents. There were no modules built under /linux/drivers/media/video or 
~radio.
BTW: this time I used 2.4.0-test13pre3 + your minipatch ...

kind regards
Norbert


On Sunday 17 December 2000 09:32, Keith Owens wrote:
> On Sun, 17 Dec 2000 09:22:04 +0100,
>
> Norbert Breun <nbreun@gmx.de> wrote:
> >having applied your patch below + modutils2.3.23-1 +
> > kernel2.4.0-test13pre2 all seems to run perfect.
> >But when starting kwintv  /dev/video is not found. /dev/video is a symling
> > on /dev/video0 and with kernel kernel2.4.0-test12 there is no problem at
> > all.
> >
> >>can't open /dev/video: Kein passendes Gerät gefunden
>
> "No suitable device found", -ENODEV.  The video driver has not been
> loaded or has not been initialised correctly.  Compare the dmesg output
>
> >from 2.4.0-test12 and 0-test13-pre2 to see what is different.  It might
>
> be a side effect of Linus's Makefile reordering.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
