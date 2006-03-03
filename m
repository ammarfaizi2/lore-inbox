Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWCCW0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWCCW0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWCCW0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:26:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56076 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751725AbWCCW0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:26:18 -0500
Date: Fri, 3 Mar 2006 23:26:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.16-rc4-mm2: drivers/rtc/utils.c should become part of a generic implementation
Message-ID: <20060303222617.GA9295@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org> <20060225033118.GF3674@stusta.de> <20060225054619.149db264@inspiron> <20060225131025.GK3674@stusta.de> <20060226194116.50f7ad2e@inspiron> <20060226185518.GM3674@stusta.de> <20060226200212.GD31256@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226200212.GD31256@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 08:02:12PM +0000, Russell King wrote:
> On Sun, Feb 26, 2006 at 07:55:18PM +0100, Adrian Bunk wrote:
> > On Sun, Feb 26, 2006 at 07:41:16PM +0100, Alessandro Zummo wrote:
> > > On Sat, 25 Feb 2006 14:10:25 +0100
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > 
> > > > 
> > > > Sounds good, but for generic functions, two adjustments are required:
> > > > - move the code to lib/
> > > > - remove rtc_ prefixes from the functions
> > > 
> > >  Moved. I'm not sure about renaming them.. 
> > > 
> > >  the functions are:
> > > 
> > > rtc_month_days
> > > rtc_time_to_tm
> > > rtc_valid_tm
> > > rtc_tm_to_time
> > > 
> > >  I think they make more sense with the rtc prefix
> > 
> > None of these functions is in any way specicific to RTC drivers.
> 
> Doesn't having them take a struct rtc_time (which is different from
> struct tm) make them rather RTC specific?

You are right, it seems I was a bit blind...

But in this case, it seems we don't need to build them unconditionally 
no matter whether RTC support is enabled in the kernel.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

