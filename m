Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291829AbSBNUsz>; Thu, 14 Feb 2002 15:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291875AbSBNUso>; Thu, 14 Feb 2002 15:48:44 -0500
Received: from pop.gmx.de ([213.165.64.20]:7959 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291851AbSBNUsi>;
	Thu, 14 Feb 2002 15:48:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Compile error with linux-2.5.5-pre1 & advansys scsi
Date: Thu, 14 Feb 2002 21:49:33 +0100
X-Mailer: KMail [version 1.3.9]
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200202142149.33035.gjwucherpfennig@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The advansys scsi driver of linux-2.5.5-pre1 doesn't compile ...

Here is the error message:

make[3]: Entering directory `/usr/src/linux/drivers/scsi'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=advansys  
-c -o advansys.o advansys.c
advansys.c:755:2: #error Please convert me to Documentation/DMA-mapping.txt
advansys.c: In function `asc_build_req':
advansys.c:6754: structure has no member named `address'
advansys.c:6754: structure has no member named `address'
advansys.c: In function `adv_get_sglist':
advansys.c:7014: structure has no member named `address'
advansys.c:7014: structure has no member named `address'
advansys.c: In function `asc_isr_callback':
advansys.c:7056: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c: In function `adv_isr_callback':
advansys.c:7231: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c: In function `AdvInitAsc3550Driver':
advansys.c:15507: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c:15528: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c: In function `AdvInitAsc38C0800Driver':
advansys.c:16129: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c:16151: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c: In function `AdvInitAsc38C1600Driver':
advansys.c:16765: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c:16790: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c: In function `AdvExeScsiQueue':
advansys.c:17982: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c: In function `AdvISR':
advansys.c:18308: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
advansys.c:18329: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a 
cast
make[3]: *** [advansys.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2



