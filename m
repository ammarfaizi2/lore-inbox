Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131097AbRAaUVz>; Wed, 31 Jan 2001 15:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131120AbRAaUVp>; Wed, 31 Jan 2001 15:21:45 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:5650 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S131097AbRAaUVg>; Wed, 31 Jan 2001 15:21:36 -0500
To: R.A.Reitsma@wbmt.tudelft.nl
Cc: kaos@ocs.com.au, miles@megapath.net, linux-kernel@vger.kernel.org,
        pellicci@home.com, Markus.Kuhn@cl.cam.ac.uk
Subject: RE: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <NCBBIEBKAIAPGJDGPNCJOENCCFAA.R.A.Reitsma@wbmt.tudelft.nl>
In-Reply-To: <4987.980895146@ocs3.ocs-net>
	<NCBBIEBKAIAPGJDGPNCJOENCCFAA.R.A.Reitsma@wbmt.tudelft.nl>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010131212120R.siemer@panorama.hadiko.de>
Date: Wed, 31 Jan 2001 21:21:20 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ruurd A. Reitsma" <R.A.Reitsma@wbmt.tudelft.nl>

> >Miles Lane <miles@megapath.net> wrote:
> >>depmod: *** Unresolved symbols in
> >>/lib/modules/2.4.1/kernel/drivers/media/radio/radio-miropcm20.o
> >>depmod: 	aci_write_cmd
> >>depmod: 	aci_indexed_cmd
> >>depmod: 	aci_write_cmd_d

> appearently Robert Siemer's patch didn't make it to the actual
> kernel. He did change the config.in and made some changes to aci.c
> to support his version of the firmware. He'll probably be happy to
> maintain the driver since I threw out the pcm20 card.

Many thanks, Ruurd, for mailing me, too! - I'm not reading
linux-kernel completely and looked only for 'aci' is subjects...

First, I've put up a new patch, so don't use this old one. Please read
my post to linux-kernel:
http://boudicca.tux.org/hypermail/linux-kernel/latest/0133.html

Second, the described problem is solved: the functions don't exists
anymore... (:

Third, my patch still has the same problem. <-:  As noted, try my
patch only when aci and radio-pcm20 is selected as module.
I will work on this issue.

And I have a request to everyone owning a miroSOUND (or Cardinal
Technologies) card:
Please try my patch and send me the version line. Mine looks like:
<ACI 0x07, id 6d/43 "m/C", (PCM20 radio)> at 0x344

The patch has some enhancements over the original; read more in my
first post:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0009.2/0260.html

The plans for the future are a well done support of the RDS functions
for the "PCM20 radio" and maybe an ALSA driver. This would help me to
support the equalizer in the "PCM20 radio" better.


Thanks,
	Robert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
