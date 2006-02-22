Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWBVSJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWBVSJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWBVSJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:09:13 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:6797 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161171AbWBVSJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:09:11 -0500
Date: Wed, 22 Feb 2006 19:09:10 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Adrian Bunk <bunk@stusta.de>
Cc: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060222180909.GA16738@MAIL.13thfloor.at>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com> <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at> <20060222023121.GB4661@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <20060222120121.GA5650@MAIL.13thfloor.at> <20060222121542.GE4661@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222121542.GE4661@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 01:15:42PM +0100, Adrian Bunk wrote:
> On Wed, Feb 22, 2006 at 01:01:21PM +0100, Herbert Poetzl wrote:
> > On Wed, Feb 22, 2006 at 04:10:01AM +0100, Adrian Bunk wrote:
> >...
> > > Except for the X86_P4_CLOCKMOD case, all of your examples are correct 
> > > usages of EMBEDDED.
> > 
> > ahem, well, then I'm definitely doing something
> > wrong when I disable the VGA console on my 2GB
> > servers, as "there's no reason to enable EMBEDDED
> > when building a kernel for systems with > 50 MB RAM"
> > 
> > sorry, I kind of disagree here, this might be useful
> > for embedded systems, but it is definitely useful
> > for other systems as well ... at least I do not like
> > the 'assumption' that every system with >50MB has
> > to have a VGA console ...
> > 
> > I agree that the 0815 distro will not need this and
> > it can be hidden behind some option ...
> 
> It's not assumed that every system with > 50 MB has a VGA console.
>
> These are options where accidentially disabling only causes problems
> for the majority of users.
>
> You can enable EMBEDDED on your 2 GB servers if you really want
> to save a few bytes in the kernel, but OTOH I doubt there is much
> practival value in reducing the kernel for a system with 2 GB RAM by a
> few kB.

it is not the size I care about, it is the missing/disabled
vga hardware (and serial console) that I care about, but
what the hell, you consider it EMBEDDED and I don't. period.

nevertheless folks put all kind of stuff under EMBEDDED
because they _think_ it actually means _SPECIALIST_ or
_EXPERT_ and just is bad namimg ...

that's something which IMHO should be clarified, and if it
is just by adding another Kconfig option which does that

> > best,
> > Herbert
> >...
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
