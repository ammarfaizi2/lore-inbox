Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313924AbSECOjB>; Fri, 3 May 2002 10:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314041AbSECOjA>; Fri, 3 May 2002 10:39:00 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:11400 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S313924AbSECOi7>; Fri, 3 May 2002 10:38:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre8
Date: Fri, 3 May 2002 08:32:12 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02050308321201.07377@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrading 2.4.19-pre3 to 2.4.19-pre8
but problem is probably created by 2.4.19-pre7 where i saw apic changes

_________________________________

init/main.o: In function `smp_init':
init/main.o(.text.init+0x5e1): undefined reference to `skip_ioapic_setup'
arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x3547): undefined reference to 
`skip_ioapic_setup'
make: *** [vmlinux] Error 1

..or perhaps my config is wrong. 
I am not sure about the apic feature.

#define CONFIG_MK7 1
...
#define CONFIG_X86_GOOD_APIC
....
#undef  CONFIG_SMP
#define CONFIG_X86_UP_APIC 1
#undef  CONFIG_X86_UP_IOAPIC
#define CONFIG_X86_LOCAL_APIC 1
-------------------------------

