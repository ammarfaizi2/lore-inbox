Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBDCcK>; Sat, 3 Feb 2001 21:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRBDCbv>; Sat, 3 Feb 2001 21:31:51 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:772 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S129047AbRBDCbu>; Sat, 3 Feb 2001 21:31:50 -0500
To: Jocelyn Mayer <jocelyn.mayer@netgem.com>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Ruurd <R.A.Reitsma@wbmt.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix dependencies for radio-miropcm20
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <3A7C6949.3070705@netgem.com>
In-Reply-To: <3A7C6949.3070705@netgem.com>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010204033125C.siemer@panorama.hadiko.de>
Date: Sun, 04 Feb 2001 03:31:25 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jocelyn!

You wrote:

> I made a very little patch to avoid
> people complaining that the kernel doesn't compile
> properly when trying to use radio miropcm20 driver.
> (I've seen some of this in french newsgroups...)

> -dep_tristate '  Miro PCM20 Radio' CONFIG_RADIO_MIROPCM20 
> $CONFIG_VIDEO_DEV                                                       
> +dep_tristate '  Miro PCM20 Radio' CONFIG_RADIO_MIROPCM20 
> $CONFIG_VIDEO_DEV $CONFIG_SOUND_ACI_MIXER                               


This was already discussed some days ago. Arjan said, that the
miropcm20 question comes before the aci question, so this is
useless. - Arjan, this is not true for 'make menuconfig' and 'make
xconfig', isn't it?

Anyway, this solution looks somewhat cleaner to me...
But you can choose on your own:  (:
As the new maintainer I'm offering the patches on

http://www.uni-karlsruhe.de/~Robert.Siemer/Private/

Jocelyn, as my patches also include bugfixes and enhancements
(especially for the miroSOUND pcm20 radio), can you recommend these to
the complaining people. - I want more testers and reports for my
patches...


Thanks,
	Robert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
