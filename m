Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSERSOT>; Sat, 18 May 2002 14:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313529AbSERSOS>; Sat, 18 May 2002 14:14:18 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:22295 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313307AbSERSOQ>; Sat, 18 May 2002 14:14:16 -0400
Message-Id: <5.1.0.14.2.20020518191232.04027ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 18 May 2002 19:13:12 +0100
To: mikeH <mikeH@notnowlewis.co.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: linux 2.5.16 and VIA Chipset
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3CE69274.7010801@notnowlewis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:42 18/05/02, mikeH wrote:
>Yeah, I have both these options enabled, but the config option is not 
>appearing (and I have had it running fine in the 2.4 series ;).
>The only mention of ACPI in .config is
>
># ACPI Support
>#
>#CONFIG_ACPI is not set
>
>otherwise there is no mention. When I put that to
>
># ACPI Support
>#
>CONFIG_ACPI=y
>
>make dep && make bzImage
>results in
>make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.5.16/include -Wall 
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
>-march=i686 -malign-functions=4  " -C  arch/i386/kernel
>make[1]: Entering directory `/usr/src/linux-2.5.16/arch/i386/kernel'
>gcc -D__KERNEL__ -I/usr/src/linux-2.5.16/include -Wall -Wstrict-prototypes 
>-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
>-pipe -mpreferred-stack-boundary=2 -march=i686 
>-malign-functions=4    -DKBUILD_BASENAME=acpi  -c -o acpi.o acpi.c
>acpi.c:53: parse error before `0'
>acpi.c: In function `acpi_get_interrupt_model':
>acpi.c:498: `ACPI_INT_MODEL_IOAPIC' undeclared (first use in this function)
>acpi.c:498: (Each undeclared identifier is reported only once
>acpi.c:498: for each function it appears in.)
>make[1]: *** [acpi.o] Error 1
>make[1]: Leaving directory `/usr/src/linux-2.5.16/arch/i386/kernel'
>make: *** [_dir_arch/i386/kernel] Error 2
>
>
>I havent done anything like copying the old .config from my 2.4 series 
>kernel, this was a clean
>tar jxvf linux-2.5.16.tar.bz2 && cd linux-2.5.16 && make menuconfig

hm. try a make mrproper

and then a make menuconfig

Anton


>Have I missed a step thats been introduced in the 2.5 series? I've only 
>run 2.2 and 2.4 before, but I was hoping 2.5 might have fixed some of the 
>VIA issues.
>
>mike
>
>Adrian Bunk wrote:
>
>>On Sat, 18 May 2002, Anton Altaparmakov wrote:
>>
>>
>>
>>>At 13:47 18/05/02, mikeH wrote:
>>>
>>>
>>>>Apologies, on closer examination of the 2.4 and 2.5 dmesg, it hangs just
>>>>before the
>>>>ACPI is going to come up. However, there is no option for it in make
>>>>menuconfig, and enabling it in .config breaks the compile.
>>>>
>>>What do you mean there is no config option in menuconfig?!? I just checked
>>>and there is "General options" ---> "ACPI Support" ---> "[ ] ACPI Support".
>>>
>>
>>There are two options that are required and it might be that one of them
>>is missing:
>>
>>1. "Code maturity level options" -> "Prompt for development and/or
>>                                     incomplete code/drivers"
>>2. "General setup" -> "Power Management support"
>>
>>Most likely the first one is the missing option (don't expect that the
>>average user has activated CONFIG_EXPERIMENTAL).
>>
>>
>>
>>>Best regards,
>>>
>>>         Anton
>>>
>>
>>cu
>>Adrian
>>
>>
>
>
>
>--
>This email was forwarded via the University of Cambridge alumni email system
>Visit http://cantab.net/ to update your forwarding details

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

