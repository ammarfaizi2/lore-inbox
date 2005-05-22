Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVEVGuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVEVGuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 02:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEVGuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 02:50:18 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:36102 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261748AbVEVGuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 02:50:11 -0400
Date: Sun, 22 May 2005 08:50:26 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
 drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-Id: <20050522085026.40e73d49.khali@linux-fr.org>
In-Reply-To: <200505212058.14851.dtor_core@ameritech.net>
References: <20050519213551.GA806@kroah.com>
	<v0eBIb5C.1116575188.8501740.khali@localhost>
	<25381867050520015339f02e9b@mail.gmail.com>
	<200505212058.14851.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> I really think that as far as I2C subsystem goes instead of creating
> arrays of attributes we should move in direction of drivers
> registering individual sensor class devices. So for example it87 would
> register 3 fans, 3 temp, sensors and 8 voltage sensors...

First, it's a matter of hardware monitoring drivers, not i2c subsystem
(both are tightly binded at the moment but I'd like this to change).

Second, not all devices have the same attributes for a temperature, fan
or voltage channel. Sure there are commonly found feature sets, but some
channels will lack some feature (e.g. it87's in8 has no min and max
limits), other chips will provide additional features (extra limits or
enhanced configurability). So I don't think you can have all devices
(and thus all drivers) fit into a single sensor class.

But of course I can be convinced your approach is better, with patches.
I don't know classes that well myself.

Thanks,
-- 
Jean Delvare
