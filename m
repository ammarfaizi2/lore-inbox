Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUFCNSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUFCNSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUFCNSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:18:18 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:26469 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261897AbUFCNSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:18:16 -0400
Message-ID: <40BF2515.8020507@blueyonder.co.uk>
Date: Thu, 03 Jun 2004 14:18:13 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.7-rc2-mm1
References: <40BDD8AC.8080706@blueyonder.co.uk> <20040602212803.0ae212ba.akpm@osdl.org>
In-Reply-To: <20040602212803.0ae212ba.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2004 13:18:17.0659 (UTC) FILETIME=[3BCA40B0:01C4496D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>  
>
>>As with 2.6.7-rc1-mm1, I'm seeing the same problem on 2.6.7-rc2-mm1. 
>> 2.6.7-rc1 and 2.6.7-rc2 are OK. It hangs needing a hard reset setting up 
>> /dev/pts, with console=ttyS1 .... same as before. SuSE 9.1 on A7N8X-E 
>> nforce2 chipset.
>>    
>>
>
>Works OK here.  Is it the `console=ttyS1' which is causing the hang?  If
>not, what?  Try removing boot options, stripping config options, etc.
>
>
>
>  
>
Bjorn Helgaas also wrote:

Can you send me the dmesg from a 2.6.7-rc1 boot (i.e., the one that
works)?  I changed some ACPI PCI IRQ routing stuff in -mm1, and I
want to make sure that's not what's causing your lockup.
===================================================================

2.6.7-rc2-mm2 also had the same problem, I rebooted with "acpi=off" and it's OK.
.config settings ---
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_SERIAL_8250_ACPI=y

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

