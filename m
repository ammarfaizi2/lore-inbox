Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293194AbSCEOnG>; Tue, 5 Mar 2002 09:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293206AbSCEOm4>; Tue, 5 Mar 2002 09:42:56 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18702 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293194AbSCEOmk>; Tue, 5 Mar 2002 09:42:40 -0500
Message-Id: <200203051440.g25Eeoq18818@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre2: <M> SGI HAL2 sound (EXPERIMENTAL) results in compile error
Date: Tue, 5 Mar 2002 16:40:04 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-pre2:

<M> SGI HAL2 sound (EXPERIMENTAL) results in:
=============================================
gcc -D__KERNEL__ -I/.share/usr/src/linux-2.4.19-pre2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i386 -DMODULE -DMODVERSIONS -include 
/.share/usr/src/linux-2.4.19-pre2/include/linux/modversions.h  
-DKBUILD_BASENAME=hal2  -c -o hal2.o hal2.c

hal2.c:36:29: asm/sgi/sgint23.h: No such file or directory
In file included from hal2.c:38:
hal2.h:24:27: asm/addrspace.h: No such file or directory
hal2.h:25:28: asm/sgi/sgihpc.h: No such file or directory
In file included from hal2.c:38:
hal2.h:272: field `desc' has incomplete type
hal2.c: In function `hal2_dac_interrupt':
hal2.c:260: `HPCDMA_XIE' undeclared (first use in this function)
hal2.c:260: (Each undeclared identifier is reported only once
hal2.c:260: for each function it appears in.)
hal2.c:260: `HPCDMA_EOX' undeclared (first use in this function)
hal2.c: In function `hal2_adc_interrupt':
hal2.c:282: `HPCDMA_XIE' undeclared (first use in this function)
hal2.c:282: `HPCDMA_EOX' undeclared (first use in this function)
hal2.c: In function `hal2_interrupt':
hal2.c:301: dereferencing pointer to incomplete type
hal2.c:301: `HPC3_PDMACTRL_INT' undeclared (first use in this function)
hal2.c:303: dereferencing pointer to incomplete type
hal2.c: In function `hal2_setup_dac':
hal2.c:393: `HPC3_PDMACTRL_RT' undeclared (first use in this function)
hal2.c:393: `HPC3_PDMACTRL_LD' undeclared (first use in this function)
hal2.c:396: dereferencing pointer to incomplete type
hal2.c: In function `hal2_setup_adc':
hal2.c:419: `HPC3_PDMACTRL_RT' undeclared (first use in this function)
hal2.c:419: `HPC3_PDMACTRL_RCV' undeclared (first use in this function)
hal2.c:419: `HPC3_PDMACTRL_LD' undeclared (first use in this function)
hal2.c:421: dereferencing pointer to incomplete type
hal2.c: In function `hal2_start_dac':
hal2.c:438: dereferencing pointer to incomplete type
hal2.c:438: warning: implicit declaration of function `PHYSADDR'
hal2.c:439: dereferencing pointer to incomplete type
hal2.c:439: `HPC3_PDMACTRL_ACT' undeclared (first use in this function)
hal2.c: In function `hal2_start_adc':
hal2.c:458: dereferencing pointer to incomplete type
hal2.c:459: dereferencing pointer to incomplete type
hal2.c:459: `HPC3_PDMACTRL_ACT' undeclared (first use in this function)
hal2.c: In function `hal2_stop_dac':
hal2.c:476: dereferencing pointer to incomplete type
hal2.c:476: `HPC3_PDMACTRL_LD' undeclared (first use in this function)
hal2.c: In function `hal2_stop_adc':
hal2.c:484: dereferencing pointer to incomplete type
hal2.c:484: `HPC3_PDMACTRL_LD' undeclared (first use in this function)
hal2.c: In function `hal2_alloc_dmabuf':
hal2.c:498: `HPCDMA_XIE' undeclared (first use in this function)
hal2.c:498: `HPCDMA_EOX' undeclared (first use in this function)
hal2.c: In function `hal2_get_buffer':
hal2.c:581: dereferencing pointer to incomplete type
hal2.c:581: `HPC3_PDMACTRL_ISACT' undeclared (first use in this function)
hal2.c:602: `HPCDMA_XIE' undeclared (first use in this function)
hal2.c:608: dereferencing pointer to incomplete type
hal2.c: In function `hal2_add_buffer':
hal2.c:649: `HPCDMA_XIE' undeclared (first use in this function)
hal2.c:660: dereferencing pointer to incomplete type
hal2.c:660: `HPC3_PDMACTRL_ISACT' undeclared (first use in this function)
hal2.c: In function `hal2_reset_pointer':
hal2.c:680: `HPCDMA_XIE' undeclared (first use in this function)
hal2.c:681: `HPCDMA_EOX' undeclared (first use in this function)
hal2.c: In function `hal2_sync_dac':
hal2.c:715: dereferencing pointer to incomplete type
hal2.c:715: `HPC3_PDMACTRL_ISACT' undeclared (first use in this function)
hal2.c: In function `hal2_request_irq':
hal2.c:1337: warning: implicit declaration of function `save_and_cli'
hal2.c:1334: warning: `flags' might be used uninitialized in this function
hal2.c: At top level:
hal2.c:1346: warning: `struct hpc3_regs' declared inside parameter list
hal2.c:1346: warning: its scope is only this definition or declaration, which 
is probably not what you want.
hal2.c: In function `hal2_alloc_resources':
hal2.c:1352: dereferencing pointer to incomplete type
hal2.c:1355: dereferencing pointer to incomplete type
hal2.c:1359: dereferencing pointer to incomplete type
hal2.c:1360: dereferencing pointer to incomplete type
hal2.c:1362: `SGI_HPCDMA_IRQ' undeclared (first use in this function)
hal2.c: In function `hal2_free_resources':
hal2.c:1374: `SGI_HPCDMA_IRQ' undeclared (first use in this function)
hal2.c: At top level:
hal2.c:1410: warning: `struct hpc3_regs' declared inside parameter list
hal2.c: In function `hal2_init_card':
hal2.c:1420: warning: implicit declaration of function `KSEG1ADDR'
hal2.c:1434: warning: passing arg 2 of `hal2_alloc_resources' from 
incompatible pointer type
hal2.c: In function `init_hal2':
hal2.c:1475: `hpc3c0' undeclared (first use in this function)
hal2.c:1475: `HPC3_CHIP0_PBASE' undeclared (first use in this function)
make[2]: *** [hal2.o] Error 1
make[2]: Leaving directory `/.share/usr/src/linux-2.4.19-pre2/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/.share/usr/src/linux-2.4.19-pre2/drivers'
make: *** [_mod_drivers] Error 2
