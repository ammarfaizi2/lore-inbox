Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVAKVDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVAKVDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVAKVDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:03:00 -0500
Received: from [195.110.122.101] ([195.110.122.101]:61325 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S262755AbVAKVBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:01:30 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Date: Tue, 11 Jan 2005 22:04:59 +0100
User-Agent: KMail/1.7.2
Cc: sensors@stimpy.netroedge.com, "Jonas Munsin" <jmunsin@iki.fi>,
       djg@pdp8.net, "Greg KH" <greg@kroah.com>,
       "LKML" <linux-kernel@vger.kernel.org>
References: <YN0o4rkI.1105435582.0805630.khali@localhost>
In-Reply-To: <YN0o4rkI.1105435582.0805630.khali@localhost>
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501112205.02322.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 January 2005 10:26, Jean Delvare wrote:

> What you have here is this default configuration, i.e. all fans are
> supposedly off. Of course it isn't the case, I assume that your fans
> are running at full speed when you turn your computer on. 

Yes, thank you for your analisys.

> Additionally, the first fan control output was turned to manual PWM
> control mode, full speed. The driver supposedly doesn't do that, I
> guess you did it yourself through the sysfs interface?

Of course, sorry.

> > > Do you know what kind of it87 chip you do have? There are three of
> > > them, IT8705F, IT8712F and a SIS950 clone (mostly similar to the
> > > IT8705F).
> See /sys/bus/i2c/devices/0-0290/name. If it says it8712 it's an IT8712F,
> if it says it87 it is a less featured IT8705F or clone. After looking at

pioppo@roentgen ~ $ cat /sys/devices/platform/i2c-0/0-0290/name
it87

> 2* I would then add a check to the it87 driver, which completely disables
> the fan speed control interface if the initial configuration looks weird
> (all fans supposedly stopped and polarity set to "active low"). This
> should protect users of the driver who have a faulty BIOS.

If the driver can perform a similar guess, couldn't it also activate a reverse 
polarity mode as well?  I think all systems boot with with full-speed fan, so 
any value you found at loading time should be the full-speed one, shouln't 
it?

BTW:
  I'm writing a report to giga-byte.

Cheers,
  Simone
-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org
