Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSBXW7C>; Sun, 24 Feb 2002 17:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291766AbSBXW6w>; Sun, 24 Feb 2002 17:58:52 -0500
Received: from a213-22-82-74.netcabo.pt ([213.22.82.74]:12293 "EHLO
	skyblade.homeip.net") by vger.kernel.org with ESMTP
	id <S291753AbSBXW6l>; Sun, 24 Feb 2002 17:58:41 -0500
Date: Sun, 24 Feb 2002 22:58:41 +0000 (WET)
From: =?iso-8859-15?Q?Jos=E9_Carlos_Monteiro?= <jcm@skyblade.homeip.net>
To: <linux-kernel@vger.kernel.org>
Subject: Emu10k1 SPDIF passthru doesn't work if CONFIG_NOHIGHMEM is not
 enabled
In-Reply-To: <Pine.LNX.4.33.0202242226510.2026-100000@skyblade.homeip.net>
Message-ID: <Pine.LNX.4.33.0202242246070.2151-100000@skyblade.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*********************************************************************
I noticed that my first message didn't reach this list before, so I'm
reposting it now. Here's its original contents:
***********************************************

Hi!
After several tests with lots of different kernels, and thanks to the help
of Hubert Mantel from SuSE, the following conclusion has been reached:

Emu10k1 SPDIF passthru with the kernel OSS driver works only if the kernel
option CONFIG_NOHIGHMEM is set. If one of the other two related options
(CONFIG_HIGHMEM4G or CONFIG_HIGHMEM64G) is used instead, the sound card is
unable to "pass" AC3 streams "through" the SPDIF output; only PCM and
multi-channel sound gets to the amp/speakers.

Emu10k1 SPDIF passthru is especially important for users who play DVDs on
their Linux boxes with digital sound from a SBLive 5.1 card.

This bug is present since kernel 2.4.13 (kernel 2.4.12 and earlier
versions don't suffer from it), and it's still present in the lastest
kernel (2.4.18-rc4).

I did all the tests using both the OSS emu10k1 driver that comes with each
kernel, and the latest driver from Creative website (v0.18). The results
were always the same. So this bug does not depend on the driver version,
it depends solely on the kernel version. I guess this is a kernel issue
then. Something that changed on kernel 2.4.13 must be the cause of this
problem.

I hope I was able to make myself clear enough. :)


Regards,
Zé

PS - I'm not a member of the mailing list, so please email me to my
personal mailbox (mailto:jcm@netcabo.pt) if you need to contact me.

*************************************************************************
Somehow this message didn't reach this list when I first sent it a couple
of days ago, so this is a repost. Development of this story can be found
on the message that I posted also to this list some minutes ago.
****************************************************************


