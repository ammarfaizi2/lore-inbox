Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264856AbTE1UQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbTE1UQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:16:11 -0400
Received: from 213-0-201-232.dialup.nuria.telefonica-data.net ([213.0.201.232]:37761
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S264856AbTE1UQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:16:10 -0400
Date: Wed, 28 May 2003 22:29:21 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what happened to i2c-proc
Message-ID: <20030528202921.GA8349@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <m3d6i3avnk.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d6i3avnk.fsf@ccs.covici.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 28 May 2003, at 12:22:23 -0400,
John Covici wrote:

> I am trying to compile appropriate modules for lm sensors in 2.5.70,
> but there seems to be no way to configure i2c-proc -- it seems to be
> there for other architectures, but not for i386.
> 
And this is probably the cause of my hardware sensors (it87.ko) not
working :-). Here is what modules.dep for my 2.4.20 kernel says:
/lib/modules/2.4.20-xfsip/kernel/drivers/sensors/it87.o:
    /lib/modules/2.4.20-xfsip/kernel/drivers/i2c/i2c-core.o \
    /lib/modules/2.4.20-xfsip/kernel/drivers/i2c/i2c-proc.o

And here what it says for my 2.5.70 kernel:
/lib/modules/2.5.70/kernel/drivers/i2c/chips/it87.ko: /lib/modules/2.5.70/kernel/drivers/i2c/i2c-sensor.ko /lib/modules/2.5.70/kernel/drivers/i2c/i2c-core.ko

Or maybe something changed in the meantime, and problems are in
user-space, the fact is it doesn't work:

server:~# sensors -v
sensors version 2.6.5

As seen on lm_sensors' home page, it seems the are still porting i2c and
lm_sensors to recent 2.5.x kernels, so maybe the problem is there. They
advise against trying to compile both i2c and lm_sensors for 2.5.x
kernels, because probably they won't work.

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.5.70)
