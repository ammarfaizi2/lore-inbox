Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUA2VcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUA2VcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:32:25 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:51855 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266451AbUA2VcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:32:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Thomas Davis <tadavis@lbl.gov>
Subject: Re: Can't boot a 2.6 kernel..
Date: Thu, 29 Jan 2004 16:32:15 -0500
User-Agent: KMail/1.6
Cc: Burton Windle <bwindle@fint.org>, lkml <linux-kernel@vger.kernel.org>
References: <40195C71.8080608@lbl.gov> <Pine.LNX.4.58.0401291527180.1094@morpheus> <401972BF.60203@lbl.gov>
In-Reply-To: <401972BF.60203@lbl.gov>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401291632.15712.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.53.166] at Thu, 29 Jan 2004 15:32:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 January 2004 15:53, Thomas Davis wrote:
>Not it.
>
>#
># Processor type and features
>#
>CONFIG_X86_PC=y
># CONFIG_X86_VOYAGER is not set
># CONFIG_X86_NUMAQ is not set
># CONFIG_X86_SUMMIT is not set
># CONFIG_X86_BIGSMP is not set
># CONFIG_X86_VISWS is not set
># CONFIG_X86_GENERICARCH is not set
># CONFIG_X86_ES7000 is not set
>CONFIG_M386=y <-- pretty old hardware???
># CONFIG_M486 is not set
># CONFIG_M586 is not set
># CONFIG_M586TSC is not set
># CONFIG_M586MMX is not set
># CONFIG_M686 is not set
># CONFIG_MPENTIUMII is not set
># CONFIG_MPENTIUMIII is not set
># CONFIG_MPENTIUM4 is not set
># CONFIG_MK6 is not set
># CONFIG_MK7 is not set
># CONFIG_MK8 is not set
># CONFIG_MELAN is not set
># CONFIG_MCRUSOE is not set
># CONFIG_MWINCHIPC6 is not set
># CONFIG_MWINCHIP2 is not set
># CONFIG_MWINCHIP3D is not set
># CONFIG_MCYRIXIII is not set
># CONFIG_MVIAC3_2 is not set
>CONFIG_X86_GENERIC=y <---
I'm running on an old athlon, (MK7 above) and I do not have the above 
option set.
I'm also working "stably" on 2.6.2-rc2-mm1.
>CONFIG_X86_L1_CACHE_SHIFT=7
>CONFIG_RWSEM_GENERIC_SPINLOCK=y
>CONFIG_X86_PPRO_FENCE=y
>CONFIG_X86_F00F_BUG=y
>CONFIG_X86_INTEL_USERCOPY=y
>CONFIG_HPET_TIMER=y
># CONFIG_HPET_EMULATE_RTC is not set
>CONFIG_SMP=y
>CONFIG_NR_CPUS=8
>CONFIG_PREEMPT=y
>CONFIG_X86_LOCAL_APIC=y
>CONFIG_X86_IO_APIC=y
>CONFIG_X86_MCE=y
>CONFIG_X86_MCE_NONFATAL=y
>CONFIG_X86_MCE_P4THERMAL=y
>CONFIG_TOSHIBA=m
>CONFIG_I8K=m
>CONFIG_MICROCODE=m
>CONFIG_X86_MSR=m
>CONFIG_X86_CPUID=m
>CONFIG_EDD=m
>CONFIG_NOHIGHMEM=y
># CONFIG_HIGHMEM4G is not set
># CONFIG_HIGHMEM64G is not set
>CONFIG_MATH_EMULATION=y
>CONFIG_MTRR=y
>CONFIG_EFI=y
>CONFIG_BOOT_IOREMAP=y
>
>next.
>
>Burton Windle wrote:
>> What about CPU selection? Compiling for a P4 when you have a P2
>> will cause the same symptom.
>>
>>
>> --
>> Burton Windle                           bwindle@fint.org
>>
>> On Thu, 29 Jan 2004, Thomas Davis wrote:
>>>Erik Mouw wrote:
>>>>On Thu, Jan 29, 2004 at 11:18:09AM -0800, Thomas Davis wrote:
>>>>>Ok, I'm trying to get a 2.6 kernel to boot on my desktop here at
>>>>> work.
>>>>>
>>>>>I have tried 3 different kernels - 2.6.1, 2.6.2rc1, and arjanv's
>>>>> 2.6.1 kernel.
>>>>>
>>>>>After the grub prompt, I get the grub kernel description, and
>>>>> then..
>>>>>
>>>>>Nothing. Nada. Zip. Zilch.
>>>>>
>>>>>2.4 kernels boot and works fine; I've attached the dmesg output
>>>>> of one of it's boots.
>>>>>
>>>>>Any ideas on what to try?
>>>>
>>>>I hope you read the post-halloween document, especially the part
>>>> about "Known gotchas"? See
>>>> http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
>>>
>>>Not it.
>>>
>>>[root@lanshark linux-2.6.1]# egrep
>>> CONFIG_VGA\|CONFIG_INPUT\|CONFIG_VGA_CONSOLE\|CONFIG_VT_CONSOLE
>>> .config CONFIG_INPUT=y
>>>CONFIG_INPUT_MOUSEDEV=m
>>>CONFIG_INPUT_MOUSEDEV_PSAUX=y
>>>CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>>>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>>>CONFIG_INPUT_JOYDEV=m
>>>CONFIG_INPUT_TSDEV=m
>>>CONFIG_INPUT_TSDEV_SCREEN_X=240
>>>CONFIG_INPUT_TSDEV_SCREEN_Y=320
>>>CONFIG_INPUT_EVDEV=m
>>>CONFIG_INPUT_EVBUG=m
>>>CONFIG_INPUT_KEYBOARD=y
>>>CONFIG_INPUT_MOUSE=y
>>>CONFIG_INPUT_JOYSTICK=y
>>>CONFIG_INPUT_JOYDUMP=m
>>>CONFIG_INPUT_TOUCHSCREEN=y
>>>CONFIG_INPUT_MISC=y
>>>CONFIG_INPUT_PCSPKR=m
>>>CONFIG_INPUT_UINPUT=m
>>>CONFIG_VT_CONSOLE=y
>>>CONFIG_VGA_CONSOLE=y
>>>
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe
>>> linux-kernel" in the body of a message to
>>> majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
