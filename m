Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVEVMcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVEVMcs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 08:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVEVMcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 08:32:48 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:27921 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261800AbVEVMcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 08:32:32 -0400
Date: Sun, 22 May 2005 14:32:44 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
 drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-Id: <20050522143244.3648427a.khali@linux-fr.org>
In-Reply-To: <25381867050522051524ea93ec@mail.gmail.com>
References: <20050519213551.GA806@kroah.com>
	<200505212058.14851.dtor_core@ameritech.net>
	<20050522085026.40e73d49.khali@linux-fr.org>
	<200505220204.52907.dtor_core@ameritech.net>
	<25381867050522051524ea93ec@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yani,

> > > First, it's a matter of hardware monitoring drivers, not i2c
> > > subsystem (both are tightly binded at the moment but I'd like this
> > > to change).
> 
> How is that change going anyway? I could really do with something
> finalized, but the last I heard about it was Mark Hoffman's patch and
> that didn't seem to go anywhere.

My bad, I didn't take the time to review Mark's work yet :(

Anyway there's a long long way to go before there is a true separation
between i2c and hwmon. Mark introduced a hwmon class, which is needed
but not sufficient. The biggest part of the work will be to move all
drivers abusing the i2c subsystem to the subsystem where they really
belong (isa/platform or superio), and get rid of i2c-isa. The hybrid
drivers (w83781d, it87 and lm78) promise to be no fun to convert. We'll
split them if that's what it takes.

-- 
Jean Delvare
