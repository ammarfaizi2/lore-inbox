Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756995AbWKVUeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995AbWKVUeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbWKVUeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:34:18 -0500
Received: from mx0.towertech.it ([213.215.222.73]:28846 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1756744AbWKVUeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:34:17 -0500
Date: Wed, 22 Nov 2006 21:34:14 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.19-rc6 6/6] rtc-omap driver
Message-ID: <20061122213414.5199f5c0@inspiron>
In-Reply-To: <200611211815.43929.david-b@pacbell.net>
References: <200611201014.41980.david-b@pacbell.net>
	<200611201028.48701.david-b@pacbell.net>
	<20061121171906.5eec32d6.akpm@osdl.org>
	<200611211815.43929.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 18:15:42 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Tuesday 21 November 2006 5:19 pm, Andrew Morton wrote:
> > On Mon, 20 Nov 2006 10:28:48 -0800
> 
> > > +		/* sometimes the alarm wraps into tomorrow */
> > > +		if (then < now) {
> > 
> > This isn't wraparound-safe.  If you have then=0xffffffff and now=0x00000001.
> > 
> > Perhaps that can't happen.
> 
> Starting in 2037 or whenever, various things will be breaking...
> 
> Probably the RTC lib routines should use a time_t, and when that gets
> changed to 64 bits then things like this will be fixed automagically.
> Right now they use "unsigned long".
> 
> I suggest Alessandro handle those issues.

 I'll make a note for switching to time_t before
 2037 :)
  


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

