Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVAHQSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVAHQSM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVAHQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:18:12 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:9222 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261201AbVAHQSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:18:08 -0500
Date: Sat, 8 Jan 2005 17:20:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Simone Piunno <pioppo@ferrara.linux.it>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050108172020.64999e50.khali@linux-fr.org>
In-Reply-To: <200501080150.44653.pioppo@ferrara.linux.it>
References: <200501080150.44653.pioppo@ferrara.linux.it>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Simone,

> Today I've tried 2.6.10-mm2 compiled for x86_64 and found something
> bad. As soon as I modprobe it87 (one of the i2c sensors drivers) the
> CPU fan  completely halts and the CPU temperature skyrockets even
> while idle. For context:
> I have an Athlon64 3200+ on a Gigabyte K8VT800 motherboard (i2c_viapro
> module) running Gentoo compiled in x86_64 mode, it87 is controlled
> through ISA bus,  VT8237 ISA bridge.

I would also be interested in the output of dmidecode [1] for your
system. This would allow me to add a workaround for your board to the
it87 driver, since the BIOS seems not to properly intialize the chip.
Sadly, there are probably many other boards which would need similar
workarounds for this chips or any other with PWM capabilities, and I
would better see the bogus BIOSes fixed than as many workarounds in our
drivers...

BTW, if you don't have the latest version of your motherboard BIOS
already, it could be worth upgrading, just in case it helps (I wouldn't
put too much hope there though).

[1] http://www.nongnu.org/dmidecode/

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
