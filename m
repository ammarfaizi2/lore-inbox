Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265562AbSJSJFu>; Sat, 19 Oct 2002 05:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265561AbSJSJFu>; Sat, 19 Oct 2002 05:05:50 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:44171 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S265562AbSJSJFt>; Sat, 19 Oct 2002 05:05:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.20-pre11, compile error - mpparse.c
Date: Sat, 19 Oct 2002 05:13:28 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210190513.28298.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mpparse.c: At top level:
mpparse.c:70: error: `dest_LowestPrio' undeclared here (not in a function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20-pre11/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


dest_LowestPrio is defined in include/asm/io-apic.h under an ifdef for 
CONFIG_X86_IO_APIC
I enable Local APIC for uniprocessors, but not IO-APIC.


[root@cobra linux-2.4]# cat /usr/src/linux-2.4/include/linux/autoconf.h|grep 
APIC
#define CONFIG_X86_GOOD_APIC 1
#define CONFIG_X86_UP_APIC 1
#undef  CONFIG_X86_UP_IOAPIC
#define CONFIG_X86_LOCAL_APIC 1
[root@cobra linux-2.4]#

	
