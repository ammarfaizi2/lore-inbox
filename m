Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUEALYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUEALYk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 07:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUEALYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 07:24:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28408 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261358AbUEALYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 07:24:38 -0400
Date: Sat, 1 May 2004 13:24:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>, Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.6-rc3: gcc 2.95: cx88 __ucmpdi2 error
Message-ID: <20040501112432.GE2541@fs.tum.de>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org> <408F9BD8.8000203@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408F9BD8.8000203@eyal.emu.id.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:56:08PM +1000, Eyal Lebedinsky wrote:
> Linus Torvalds wrote:
> >s390, cifs, ntfs, ppc, ppc64, cpufreq upates. Oh, and DVB and USB.
> >
> >I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many 
> >people as possible will test this.
> 
> OK, I'll bite. Building using :
> 	# gcc --version
> 	2.95.4
> 
> depmod says:
> 
>...
> WARNING: /lib/modules/2.6.6-rc3/kernel/drivers/media/video/cx88/cx8800.ko 
> needs unknown symbol __ucmpdi2

I'm also seeing this, but only with gcc 2.95, not with gcc 3.3.3 .

It comes from drivers/media/video/cx88/cx88-video.c, more exactly from 
the switch in set_tvaudio.

But I have to admit I don't understand why exactly it does happen.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

