Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUGLVZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUGLVZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUGLVZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:25:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:44944 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263687AbUGLVZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:25:11 -0400
Subject: Re: desktop and multimedia as an afterthought?
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0407121507530.20260-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0407121507530.20260-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Message-Id: <1089667506.15341.81.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 14:25:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 12:12, Mark Hahn wrote:

> > The CK patches floated around as separate patches for a long time, even
> > though they brought significant improvements to the kernel w.r.t.
> > desktop and media.
> 
> how do you show this?  measured how, under what load, with what benefits?

Run the vanilla kernel. Run Ardour to do the digital audio work, plus a
sequencer (Rosegarden, Muse, Seq24) to drive the MIDI gear. Do a
multitrack record.
If you fiddle too much with Mozilla and/or Evolution, GIMP, gThumb,
OpenOffice while doing the record session, Ardour will skip parts of the
tracks.

Repeat everything, using a CK kernel instead (or the kernel provided by
PlanetCCRMA). No amounts of Mozilla/Evolution/etc normal usage will make
Ardour skip anything.

Want numbers?
0 skips if running the CK/PlanetCCRMA kernel.
>0 skips if running vanilla kernel.

Anything more than 0 is not acceptable for this type of usage.

System is:
AthlonXP/1800, 512MB RAM, NForce1 mobo, Audigy2, ALSA, Fedora 2 and
various flavours of Linux-2.6 (similar results with Red Hat 9 and
Linux-2.4)
Similar results reported by almost anyone doing sound studio type of
work with Linux, on a large variety of hardware.

> > And rightly so. If i reboot my computer into Windows and perform the
> > same multimedia tasks, there are fewer chances of it skipping frames or
> 
> this normally shows only that windows drivers are better.

Which drivers? Sound card?

The same issues manifest when doing an all-internal record.

E.g.: run a softsynth (a software that generates sound, such as
Specimen, AlsaModularSynth or ZynAddSubFX) and route the output to JACK.
Run some LADSPA effects (reverb, chorus, flanger) on top of the JACK
pipe for good measure. At the other end of the JACK pipe run Ardour,
Audacity or any other DAW (digital audio workstation) software. Add a
few more softsynth instances, and drive them via a sequencer.
All sound is routed inside the computer. It never touches the sound
card. Any driver that's involved is the IDE or SCSI driver (because the
DAW dumps the audio tracks onto the hard-drive). Even if the driver was
defective, it wouldn't probably matter, because of the multiple levels
of caching that are involved.

Yet the exact same problems happen (skipping parts of the tracks if
system is only marginally used by other apps), with the exact same
solution (apply the CK patches to the kernel).

-- 
Florin Andrei

http://florin.myip.org/

