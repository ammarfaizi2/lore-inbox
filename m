Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVL0S2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVL0S2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 13:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVL0S2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 13:28:39 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:29199 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932366AbVL0S2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 13:28:38 -0500
Date: Fri, 23 Dec 2005 11:21:27 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Gene Heskett <gene.heskett@verizononline.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
Message-Id: <20051223112127.2bb67a07.khali@linux-fr.org>
In-Reply-To: <200512211835.34309.gene.heskett@verizon.net>
References: <200512201505.43199.gene.heskett@verizon.net>
	<200512211725.39984.gene.heskett@verizon.net>
	<20051222000025.4ee54e84.khali@linux-fr.org>
	<200512211835.34309.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

> [root@coyote root]# i2cdump 1 0x4e b
> WARNING! This program can confuse your I2C bus, cause data loss and 
> worse!
> I will probe file /dev/i2c-1, address 0x4e, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 08 33 33 03 80 01 00 00 00 ff 00 00 00 00 00    .?33???.........
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

Don't know what it is, but most certainly not a temperature sensor.

> THRM at default, and temp2, both result in only one reading, of about 
> 156F in gkrellm, I guess I better truck this thing out to an air hose 
> & give it a litteral blow job.

If ACPI gets the temperature value from the W83627HF chip as the
w83627hf driver does, I would expect concurrent access issues. If you
are having temperature readings trouble again, try only using either of
the (ACPI) thermal or w83627hf drivers, not both, and see if things
improve.

I have no idea how such conflicts can be prevented in the big picture.

-- 
Jean Delvare
