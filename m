Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVKKTCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVKKTCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVKKTCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:02:03 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:12530 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751052AbVKKTCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:02:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RXae6aMAZ44fZ9ixK43hXFS/oLjdXOyX1OENXlVHlbEd5Oi8aulTyktTv2VSQKLCy59aRaZI/bJutUxuOV87Rb3jHa/8Re/dV8bISEt7YW56Mnq2mJCA3v3RrrBMk0Rc+w67pEKezfFihApPu5fbjLwwCsF/AagBXzJarTpN1AI=
Message-ID: <195c7a900511111102t240b8195y58a2c167f0185d70@mail.gmail.com>
Date: Fri, 11 Nov 2005 19:02:00 +0000
From: roucaries bastien <roucaries.bastien@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [BUG] Ali snd soft lookup on 2.6.14 (regression)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5h64qzyq8o.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <195c7a900511101418r25aa43e6gc5cdeeac17aa0c7c@mail.gmail.com>
	 <s5hr79nz3b4.wl%tiwai@suse.de>
	 <195c7a900511111040p7947267brd99ce0be3c1130f4@mail.gmail.com>
	 <s5h64qzyq8o.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/05, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 11 Nov 2005 18:40:25 +0000,
> roucaries bastien wrote:
> >
> > On 11/11/05, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Thu, 10 Nov 2005 22:18:36 +0000,
> > > roucaries bastien wrote:
> > > >
> > > > Recently I upgrade from 2.6.10 to 2.6.14 and I my sound card doesn't
> > > > work anymore.
> > > Does the patch below fix?
> > It fix the BUG but I have always no sound :-(
> >
> > dmesg shows now:
> >
> > AC'97 1 does not respond - RESET
> > AC'97 1 access is not valid [0xffffffff], removing mixer.
>
> This is the secondary codec, so it's no fatal error.
>
> Make sure that you set up your mixer correctly again.

For sure:
$amixer
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [on]
  Front Right: Playback 23 [74%] [on]
Simple mixer control 'Headphone Jack Sense',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 28 [90%] [on]
  Front Right: Playback 28 [90%] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off] Capture [off]
  Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Line Jack Sense',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 28 [90%] [on] Capture [off]
  Front Right: Playback 28 [90%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono:
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 2 [6%] [on] Capture [off]
  Front Right: Playback 2 [6%] [on] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities:
  Mono:
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Stereo Mic',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

>
>


Before your patch I can hear something like the headphone setup (a
little noise like water falling on water) but now didn't hear
anything.

Any idea

> Takashi
>
