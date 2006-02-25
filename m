Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWBYWHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWBYWHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWBYWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:07:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16905 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932150AbWBYWHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:07:39 -0500
Date: Sat, 25 Feb 2006 23:07:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060225220737.GE3674@stusta.de>
References: <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at> <20060222023121.GB4661@stusta.de> <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be> <20060225124606.GI3674@stusta.de> <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr> <20060225145049.GQ3674@stusta.de> <Pine.LNX.4.61.0602251628050.13355@yvahk01.tjqt.qr> <20060225154028.GU3674@stusta.de> <Pine.LNX.4.61.0602252300200.7535@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602252300200.7535@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 11:01:03PM +0100, Jan Engelhardt wrote:
> >> >> You said that INPUT was not a driver, right. But without it, a keyboard 
> >> >> won't work, will it?
> >> >
> >> >Yes, you do need INPUT for a keyboard.
> >> >No, INPUT alone does not support any hardware - that's the job of the 
> >> >drivers depending on INPUT.
> >> >No, I don't understand what your question wants to achieve.
> >> 
> >> Let's look at another subsystem:
> >> "Yes, you do need SND for a soundcard."
> >> "No, SND alone does not support any hardware - that's the job of the drivers
> >> depending on SND."
> >> Should SND also be made a bool like INPUT?
> >
> >No, SND=m is also possible in the EMBEDDED=n case.
> >
> This example was to show that INPUT should not be y-only. Except if you plan to
> make SND y-only too.


Please try to understand the following:
- INPUT=m is already only available if EMBEDDED=y
- as I did already explain, EMBEDDED=y and MODULES=y at the same 
  time doesn't make much  sense

As I already said, SND=m is completely different since it is also 
available in the (common) EMBEDDED=n case.


> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

