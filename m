Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTHVWYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTHVWYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:24:55 -0400
Received: from post.tau.ac.il ([132.66.16.11]:13450 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262856AbTHVWYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:24:50 -0400
Subject: Re: 2.6.0-test3+bk: ACPI does not switch off the computer
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030822062945.GA1128@steel.home>
References: <20030822062945.GA1128@steel.home>
Content-Type: text/plain
Message-Id: <1061581183.3498.5.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 00:41:34 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.1; VDF: 6.21.0.26; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 09:29, Alex Riesen wrote:
> Actually it started happening from -test3.
> The last I see on screen is "Power down." and the system is halted.
> CAD reboots it.
> 

I have the same problem with some kernels (I get this with 2.4.21, don't
think with 2.6.0-test3-bk8 but not sure since its very unstable on my
machine and I don't have the time to play with it now).

The solution was to change the sleep level for ACPI when turnign of from
S5 to S4 (don't know why this works). In the file 
kernel-source-2.6.0-test3-bk8/drivers/acpi/sleep/poweroff.c
function
acpi_power_off
try replacing ACPI_STATE_S5 with ACPI_STATE_S4

> -alex
> 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> # CONFIG_SOFTWARE_SUSPEND is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI_HT=y
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_THERMAL=m
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> 
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Micha Feigin
michf@math.tau.ac.il

