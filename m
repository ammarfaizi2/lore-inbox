Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbVKSDZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbVKSDZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbVKSDZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 22:25:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41652 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161233AbVKSDZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 22:25:02 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Lee Revell <rlrevell@joe-job.com>
To: Rob Landley <rob@landley.net>
Cc: Adrian Bunk <bunk@stusta.de>, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511182043.34655.rob@landley.net>
References: <1132020468.27215.25.camel@mindpipe>
	 <200511181933.27320.rob@landley.net> <1132365780.6874.53.camel@mindpipe>
	 <200511182043.34655.rob@landley.net>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 22:22:51 -0500
Message-Id: <1132370572.6874.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 20:43 -0600, Rob Landley wrote:
> On Friday 18 November 2005 20:02, Lee Revell wrote:
> > > Speaking of which: I've been playing with qemu recently, and the sound
> > > card it emulates is a sound blaster 16.  Which only seems to have an OSS
> > > driver, no ALSA...
> > >
> > > This is known?  If so I might take a whack at porting this if I get
> > > really bored this weekend...
> >
> > There already is an ALSA driver, check out sound/isa/sb/sb16.c:
> 
> Ok, so where is the config option?
> 

sound/isa/Kconfig:

253 config SND_SB16
254         tristate "Sound Blaster 16 (PnP)"
255         depends on SND
256         select SND_OPL3_LIB
257         select SND_MPU401_UART
258         select SND_PCM
259         select SND_GENERIC_DRIVER
260         help
261           Say Y here to include support for Sound Blaster 16 soundcards
262           (including the Plug and Play version).
263 
264           To compile this driver as a module, choose M here: the module
265           will be called snd-sb16.

Lee


