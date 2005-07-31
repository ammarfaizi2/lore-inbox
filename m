Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVGaT3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVGaT3e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVGaT3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:29:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61961 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261930AbVGaT3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:29:32 -0400
Date: Sun, 31 Jul 2005 21:29:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Haninger <ahaning@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050731192929.GG3608@stusta.de>
References: <20050726150837.GT3160@stusta.de> <105c793f050726091722f3cbb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105c793f050726091722f3cbb2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 12:17:14PM -0400, Andrew Haninger wrote:
> On 7/26/05, Adrian Bunk <bunk@stusta.de> wrote:
> >  config SOUND_OPL3SA2
> >         tristate "Yamaha OPL3-SA2 and SA3 based PnP cards"
> > -       depends on SOUND_OSS
> > +       depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
> >         help
> >           Say Y or M if you have a card based on one of these Yamaha sound
> >           chipsets or the "SAx", which is actually a SA3. Read
> Forgive me if I'm misreading this (I'm hardly a coder and no kernel
> hacker) but, as it stands, the OPL3SA2 driver provided by ALSA and the
> main kernel tree work but are not correctly detected by ALSA's
> detection routines (in alsaconf) on the 2.6 kernel. The OSS drivers
> work, as well, but (AFAIK) there are no methods of automatic
> configuration with the OSS drivers.
> 
> So, for people who don't feel like configuring ALSA with their OPL3SA2
> card, the OSS modules may be easier to configure and thus should be
> left in until the ALSA/2.6 kernel problems are worked out with the
> OPL3SA2.

This is kernel bug #3117 [1] / ALSA bug #879 [2]?

> -Andy

cu
Adrian

[1] http://bugzilla.kernel.org/show_bug.cgi?id=3117
[2] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=879

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

