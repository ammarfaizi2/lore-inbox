Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbVIOUQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbVIOUQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbVIOUQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:16:29 -0400
Received: from k1.dinoex.de ([80.237.200.138]:5331 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S1161007AbVIOUQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:16:28 -0400
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
From: Jochen Hein <jochen@jochen.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ACPI] wrong documentation for /proc/acpi/sleep?
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
Date: Thu, 15 Sep 2005 22:00:11 +0200
Message-ID: <87mzme3xv8.fsf@echidna.jochen.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The documentation in Documentation/power/swsusp.txt reads:

,----
| Sleep states summary
| ====================
| 
| There are three different interfaces you can use, /proc/acpi should
| work like this:
| 
| In a really perfect world:
| echo 1 > /proc/acpi/sleep       # for standby
| echo 2 > /proc/acpi/sleep       # for suspend to ram
| echo 3 > /proc/acpi/sleep       # for suspend to ram, but with more
| power conservative
| echo 4 > /proc/acpi/sleep       # for suspend to disk
| echo 5 > /proc/acpi/sleep       # for shutdown unfriendly the system
| 
| and perhaps
| echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
`----

I do get:
root@hermes:~# echo 2 > /proc/acpi/sleep
bash: /proc/acpi/sleep: No such file or directory

Kernel release is 2.6.14-rc1, ACPI/Power-related-config:
,----
| root@hermes:/usr/src/linux-2.6.14-rc1# grep ACPI .config
| # Power management options (ACPI, APM)
| # ACPI (Advanced Configuration and Power Interface) Support
| CONFIG_ACPI=y
| CONFIG_ACPI_AC=y
| CONFIG_ACPI_BATTERY=y
| CONFIG_ACPI_BUTTON=y
| CONFIG_ACPI_VIDEO=y
| CONFIG_ACPI_HOTKEY=y
| CONFIG_ACPI_FAN=y
| CONFIG_ACPI_PROCESSOR=y
| CONFIG_ACPI_THERMAL=y
| # CONFIG_ACPI_ASUS is not set
| CONFIG_ACPI_IBM=y
| # CONFIG_ACPI_TOSHIBA is not set
| CONFIG_ACPI_BLACKLIST_YEAR=0
| CONFIG_ACPI_DEBUG=y
| CONFIG_ACPI_EC=y
| CONFIG_ACPI_POWER=y
| CONFIG_ACPI_SYSTEM=y
| # CONFIG_ACPI_CONTAINER is not set
| CONFIG_X86_ACPI_CPUFREQ=y
| CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
| # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
| # CONFIG_HOTPLUG_PCI_ACPI is not set
| CONFIG_PNPACPI=y
| root@hermes:/usr/src/linux-2.6.14-rc1# grep POWER .config
| CONFIG_ACPI_POWER=y
| # CONFIG_APM_REAL_MODE_POWER_OFF is not set
| CONFIG_CPU_FREQ_GOV_POWERSAVE=y
| # CONFIG_X86_POWERNOW_K6 is not set
| # CONFIG_X86_POWERNOW_K7 is not set
| # CONFIG_X86_POWERNOW_K8 is not set
| # CONFIG_USB_POWERMATE is not set
| root@hermes:/usr/src/linux-2.6.14-rc1# grep SWSU .config
| CONFIG_SWSUSP_ENCRYPT=y
`----

System is a Thinkpad R40, Debian/sarge with kernel 2.6.14-rc1. Did I
miss something obvious?

Jochen

-- 
#include <~/.signature>: permission denied
