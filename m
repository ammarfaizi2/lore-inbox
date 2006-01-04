Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWADLQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWADLQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWADLQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:16:20 -0500
Received: from gate.perex.cz ([85.132.177.35]:6818 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751692AbWADLQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:16:19 -0500
Date: Wed, 4 Jan 2006 12:16:18 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20060104031300.270541d9.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.61.0601041214050.9321@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <200601031347.19328.s0348365@sms.ed.ac.uk>
 <200601031452.10855.ak@suse.de> <mailman.1136300646.6679.linux-kernel2news@redhat.com>
 <20060104031300.270541d9.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Pete Zaitcev wrote:

> On Tue, 3 Jan 2006 14:01:40 +0000, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> 
> > Is multiple-source mixing really a "high end" requirement? When I last 
> > checked, the OSS driver didn't support multiple applications claiming it at 
> > once, thus requiring you to use "more bloat" like esound, arts, or some other 
> > crap to access your soundcard more than once at any given time.
> 
> If ALSA's OSS emulator does not support mixing properly, it's a bug
> in ALSA, clearly, because real OSS in 2.4 allowed for mixing, as long
> as the hardware supported it. I played Doom while listening to MP3s on
> ymfpci (which, in fact, was a copy of ALSA's ymfpci with OSS API on top).
> 
> If ALSA developers wanted, they could have supported mixing in their OSS
> emulator. They intentionally chose not to, in order to create an incentive
> for developers to program in native ALSA.

You're in a mistake. ALSA supported multi-open feature for the hardware 
capable devices as first before any OSS drivers and it's available for the 
OSS emulation, too.

The thread is about simple hardware without this capability, so the mixing 
must be processed in software.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
