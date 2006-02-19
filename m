Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWBSXxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWBSXxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWBSXxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:53:44 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43461 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932453AbWBSXxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:53:44 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060219234644.GD15608@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe>
	 <200602192323.08169.s0348365@sms.ed.ac.uk>
	 <1140391929.2733.430.camel@mindpipe>  <20060219234644.GD15608@elf.ucw.cz>
Content-Type: multipart/mixed; boundary="=-UjEe+XwyqdGUeaF92T0U"
Date: Sun, 19 Feb 2006 18:53:41 -0500
Message-Id: <1140393222.2733.438.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UjEe+XwyqdGUeaF92T0U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-02-20 at 00:46 +0100, Pavel Machek wrote:
> Hi!
> 
> > > I'm still using 1.0.9 on 2.6.16-rc4 with no problems, Audigy 2 (one
> > > that uses 
> > > emu10k1). 
> > 
> > It's a specific change to the SBLive! that did not affect the Audigy
> > that causes alsa-lib 1.0.10+ to be required on 2.6.14 and up.  These
> > types of incompatible changes should be rare.
> 
> Do you have that patch somewhere handy?
> 

Attached

> How do I tell alsa-lib version?
> 

Check your distro's package manager.

> Does alsa-lib bug still affect me when I'm using oss emulation?
> 

No.

> > It was a necessary precursor to fixing the well known "master volume
> > only controls front speakers" bug.
> 
> 								Pavel

--=-UjEe+XwyqdGUeaF92T0U
Content-Disposition: attachment; filename=emu10k1-fix-the-confliction-of-front-control.patch
Content-Type: text/x-patch; name=emu10k1-fix-the-confliction-of-front-control.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix the confliction of 'Front' controls on models with STAC9758 codec.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 sound/pci/emu10k1/emumixer.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.15.3/sound/pci/emu10k1/emumixer.c
===================================================================
--- linux-2.6.15.3.orig/sound/pci/emu10k1/emumixer.c
+++ linux-2.6.15.3/sound/pci/emu10k1/emumixer.c
@@ -750,6 +750,8 @@ int __devinit snd_emu10k1_mixer(emu10k1_
 		"Master Mono Playback Volume",
 		"PCM Out Path & Mute",
 		"Mono Output Select",
+		"Front Playback Switch",
+		"Front Playback Volume",
 		"Surround Playback Switch",
 		"Surround Playback Volume",
 		"Center Playback Switch",

--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


--=-UjEe+XwyqdGUeaF92T0U--

