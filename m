Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWIHMWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWIHMWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWIHMWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:22:40 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:61964 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750930AbWIHMWk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:22:40 -0400
Date: Fri, 8 Sep 2006 14:22:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: =?ISO-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
       Samuel Tardieu <sam@rfc1149.net>, linux-kernel@vger.kernel.org,
       wim@iguana.be
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Message-Id: <20060908142249.f84ca41a.khali@linux-fr.org>
In-Reply-To: <45005657.8000509@gmail.com>
References: <87fyf5jnkj.fsf@willow.rfc1149.net>
	<44FEAD7E.6010201@draigBrady.com>
	<45005657.8000509@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pádraig Brady wrote:
> > Is W83697HG a good name?
> >   
> 
> 
> could you add a suffix, say _watchdog ?
> 
> the name youve got is confusingly close to the convention used in 
> drivers/hwmon
> 
>  ls hwmon/w*.c
> hwmon/w83627ehf.c  hwmon/w83627hf.c  hwmon/w83781d.c  hwmon/w83791d.c  
> hwmon/w83792d.c  hwmon/w83l785ts.c

I second Jim's suggestion. Given the name of the other Winbond watchdog
drivers:

char/watchdog/w83627hf_wdt.c 
char/watchdog/w83977f_wdt.c
char/watchdog/w83877f_wdt.c

I'd suggest w83697hf_wdt.c. The W83697HG if the lead-free version of
the older W83697HF and they are otherwise the same chip. BTW I see that
there's already a driver for the W83627HF watchdog. Given the
similarities between the W83627HF and the W83697HF, it might make sense
to add support for the latter directly in the w83627hf_wdt driver,
rather than writing a brand new one.

-- 
Jean Delvare
