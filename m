Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965390AbVKHHxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965390AbVKHHxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965392AbVKHHxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:53:05 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:27528 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965390AbVKHHxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:53:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=sO69c0nHkVJ9W4HyIpeX6kp4bfru5H9wWzonL7MxgwiN1Zj6xfhQMJdwyfO9OHfhpqP+h0XWyFblmXSCbviBC0LO6jdspudkcfCewHYqFWcRCPBkawgifk6jXTx3/cr9VFoQGg107SOYchOS5udiqPJbVAZWP/sd7VQnZPxOBtw=
Message-ID: <43705958.5040802@gmail.com>
Date: Tue, 08 Nov 2005 08:52:56 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
References: <20051006072749.GA2393@spitz.ucw.cz>	 <20051107164715.GA1534@elf.ucw.cz> <1131411772.3003.1.camel@linux-hp.sh.intel.com>
In-Reply-To: <1131411772.3003.1.camel@linux-hp.sh.intel.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li ha scritto:

>On Mon, 2005-11-07 at 17:47 +0100, Pavel Machek wrote:
>  
>
>>Hi!
>>
>>    
>>
>>>echo shutdown > /sys/power/disk
>>>echo disk > /sys/power/state
>>>
>>>Unable to handle kernel NULL pointer dereference at virtual address 00000004
>>> printing eip:
>>>EIP:    0060:[<c0132a5e>]    Not tainted VLI
>>>EFLAGS: 00010286   (2.6.14-git4)
>>>EIP is at enter_state+0xe/0x90
>>>      
>>>
>>It works for me, with pretty recent tree. But I see a potential
>>problem there, you are not using ACPI, right?
>>
>>    
>>
>It's my bad. Thanks for fixing this, Pavel. Maybe patrizio didn't enable
>ACPI sleep.
>
>Thanks,
>Shaohua
>
>
>  
>
no i hadn't.

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set


