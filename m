Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUAHWEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266313AbUAHWEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:04:34 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:49169 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S266293AbUAHWEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:04:13 -0500
Date: Thu, 8 Jan 2004 23:05:59 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: i2c_adapter i2c-0: Bus collision!
Message-Id: <20040108230559.05a5674c.khali@linux-fr.org>
In-Reply-To: <1073527236.624.7.camel@buick>
References: <1073527236.624.7.camel@buick>
Reply-To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i2c_adapter i2c-0: Bus collision! SMBus may be locked until next hard
> reset. (sorry!)
> 
> Kernel 2.6.0 with lm-sensors 2.8.2.

Are you able to reproduce the same behavior with kernel 2.4.24 and
lm-sensors 2.8.2?

> I get very weird results, especially on the fan, but others as well.
> Here are three runs of sensors:
> (...)

Could you provide a few outputs of "i2cdump 0 0x2d"? I wonder if this
will show read errors (as "XX") or simply changing values.

Does your BIOS provide a feature such as "Circle Of Protection" or
anything that sounds like "active" hardware monitoring? Is it enabled?

If you have any other chips (eeproms for example) on the bus, do you
observe similar behavior with these?

> It works fine with MBM in Windows. Well, MBM is having some troubles
> with the temperature (it gets lower and lower as time pass, and ends
> on about 8-9 degrees celsius. But fan and temperatures are read just
> fine, never any glitch. On thing thing though, the Vcore2 is 1,70. The
> Bios reports it correctly, but both MBM and LM-sensors says 1,50. Have
> no idea why. The 1,50 is static, never changes, while VCore1 (which
> ideally should be 1,75) varies from 1,75 to 1,79. In the BIOS both
> seem sane, and varies with 3-4 degrees.
> 
> I guess all these problems are because of the bus collision, which I
> have read usually happens because of bad boards. Which I admit that I
> do have, but it works in Windows :(

Which motherboard is it?

Did you have to enable any particular option in MBM?

> What are the most common reasons for the bus collisions (...)?

Bad brakes?

Just kidding... ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
