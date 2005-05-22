Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVEVNje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVEVNje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 09:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVEVNje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 09:39:34 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:24079 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261209AbVEVNj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 09:39:28 -0400
Date: Sun, 22 May 2005 15:39:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
 drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-Id: <20050522153945.04690929.khali@linux-fr.org>
In-Reply-To: <25381867050522060561a288c@mail.gmail.com>
References: <20050519213551.GA806@kroah.com>
	<200505212058.14851.dtor_core@ameritech.net>
	<20050522085026.40e73d49.khali@linux-fr.org>
	<200505220204.52907.dtor_core@ameritech.net>
	<25381867050522051524ea93ec@mail.gmail.com>
	<20050522143244.3648427a.khali@linux-fr.org>
	<25381867050522060561a288c@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yani,

> And i2c-ipmi remember? :) Does that mean Mark's class is finalized and
> I can work with it? Or is there some more work to be done on that
> front too? If so I can probably help out.

I can't tell, I didn't even give his code a try :( If you have some
spare time, try applying the proposed patches, see how they work for you
and how you could use the new class in bmcsensors.

However, as I understand it, the hwmon class will be added to the
drivers, it isn't meant to replace anything. This will simply let us
search for hwmon stuff by class rather than assuming that all hwmon
drivers are devices on i2c busses, so it's more like a helper for
user-space tools. I don't think it solves the hwmon-is-not-i2c issue on
the kernel side at all.

-- 
Jean Delvare
