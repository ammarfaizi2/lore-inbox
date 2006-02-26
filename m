Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWBZUCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWBZUCT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWBZUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:02:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47112 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751398AbWBZUCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:02:18 -0500
Date: Sun, 26 Feb 2006 20:02:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.16-rc4-mm2: drivers/rtc/utils.c should become part of a generic implementation
Message-ID: <20060226200212.GD31256@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <20060224031002.0f7ff92a.akpm@osdl.org> <20060225033118.GF3674@stusta.de> <20060225054619.149db264@inspiron> <20060225131025.GK3674@stusta.de> <20060226194116.50f7ad2e@inspiron> <20060226185518.GM3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226185518.GM3674@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 07:55:18PM +0100, Adrian Bunk wrote:
> On Sun, Feb 26, 2006 at 07:41:16PM +0100, Alessandro Zummo wrote:
> > On Sat, 25 Feb 2006 14:10:25 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > 
> > > Sounds good, but for generic functions, two adjustments are required:
> > > - move the code to lib/
> > > - remove rtc_ prefixes from the functions
> > 
> >  Moved. I'm not sure about renaming them.. 
> > 
> >  the functions are:
> > 
> > rtc_month_days
> > rtc_time_to_tm
> > rtc_valid_tm
> > rtc_tm_to_time
> > 
> >  I think they make more sense with the rtc prefix
> 
> None of these functions is in any way specicific to RTC drivers.

Doesn't having them take a struct rtc_time (which is different from
struct tm) make them rather RTC specific?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
