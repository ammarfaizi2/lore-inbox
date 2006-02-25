Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWBYMqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWBYMqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWBYMqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:46:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19717 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932696AbWBYMqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:46:08 -0500
Date: Sat, 25 Feb 2006 13:46:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060225124606.GI3674@stusta.de>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr> <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com> <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at> <20060222023121.GB4661@stusta.de> <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 12:58:01PM +0100, Geert Uytterhoeven wrote:
> On Wed, 22 Feb 2006, Adrian Bunk wrote:
> > On Wed, Feb 22, 2006 at 02:34:11AM +0100, Herbert Poetzl wrote:
> > > On Mon, Feb 20, 2006 at 02:28:32PM +0100, Adrian Bunk wrote:
> > > > On Mon, Feb 20, 2006 at 12:33:55PM +0900, Samuel Masham wrote:
> > That's not a good solution since EMBEDDED is really only about 
> > additional space savings - even if you are an "expert", there's no 
> > reason to enable EMBEDDED when building a kernel for systems 
> > with > 50 MB RAM.
> 
> and
> 
> On Fri, 17 Feb 2006, Adrian Bunk wrote:
> > And I've already given numbers why CONFIG_EMBEDDED=y and
> > CONFIG_MODULES=y at the same time is insane.
> 
> But if my m68k box has less than 47.68 MiB RAM, I may want CONFIG_EMBEDDED=y,
> and I like to have CONFIG_MODULES=y...

My 50 MB number was much too high (I didn't want to think where exactly 
to set the borderline).

My point is that if you are in an environment that is that space limited 
that you want to see options that allow e.g. not building futexes, 
module support with an impact of approx. 10% on code size would be one 
of the first things you should disable.

> Gr{oetje,eeting}s,
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

