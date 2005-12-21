Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVLUSWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVLUSWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVLUSWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:22:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7946 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932485AbVLUSWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:22:16 -0500
Date: Wed, 21 Dec 2005 19:22:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
Message-ID: <20051221182214.GB3888@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de> <s5hr786zfzm.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr786zfzm.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 03:23:09PM +0100, Takashi Iwai wrote:
> At Tue, 20 Dec 2005 21:23:25 +0100,
> Adrian Bunk wrote:
> > 
> > On Tue, Dec 20, 2005 at 11:59:20AM -0800, Linus Torvalds wrote:
> > > 
> > > 
> > > On Tue, 20 Dec 2005, Adrian Bunk wrote:
> > > >
> > > > > Adrian, does it work if you change the "module_init()" in 
> > > > > sound/sound_core.c into a "fs_initcall()"?
> > > > 
> > > > No, this didn't work.
> > > > 
> > > > What did work was to leave sound/sound_core.c alone
> > > 
> > > Can you do try the other way again, with sound/core/sound.c fixed too?
> > >...
> > 
> > This works in the sense that the kernel boots and my saa7134 TV card is 
> > giving both audio and video output.
> > 
> > But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
> > longer working.
> 
> What is missing there?  No sound card entry in /proc/asound/cards?
>...

<--  snip  -->

0 [SAA7134        ]: SAA7134 - SAA7134
                     saa7134[0] at 0xed800000 irq 18
1 [V8237          ]: VIA8237 - VIA 8237
                     VIA 8237 with AD1888 at 0xe000, irq 21

<--  snip  -->

What changed compared to the working setup (if the bug is really here) 
is the order of the two.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

