Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSEHJqo>; Wed, 8 May 2002 05:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEHJqn>; Wed, 8 May 2002 05:46:43 -0400
Received: from vivi.uptime.at ([62.116.87.11]:59622 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S312590AbSEHJqm>;
	Wed, 8 May 2002 05:46:42 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Problems with mm on Alpha...
Date: Wed, 8 May 2002 11:46:28 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <003701c1f675$3d1c5cc0$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020508113428.D31998@dualathlon.random>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi volks!

Can anybody help/explain this to me:

[ ... ]
make[1]: Entering directory `/root/linux-2.5.14/mm'
make all_targets
make[2]: Entering directory `/root/linux-2.5.14/mm'
gcc -D__KERNEL__ -I/root/linux-2.5.14/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6
-DKBUILD_BASENAME=memory  -c -o memory.o memory.c
memory.c: In function `__free_pte':
memory.c:80: warning: implicit declaration of function `pte_pfn'
memory.c:81: warning: implicit declaration of function `pfn_valid'
memory.c:83: warning: implicit declaration of function `pfn_to_page'
memory.c:83: warning: assignment makes pointer from integer without a
cast
memory.c: In function `copy_page_range':
memory.c:289: warning: assignment makes pointer from integer without a
cast
memory.c: In function `zap_pte_range':
memory.c:369: warning: assignment makes pointer from integer without a
cast
memory.c: In function `follow_page':
memory.c:490: warning: return makes pointer from integer without a cast
memory.c: In function `remap_pte_range':
memory.c:879: invalid type argument of `->'
memory.c:880: warning: implicit declaration of function `pfn_pte'
memory.c:880: incompatible types in assignment
memory.c: In function `do_wp_page':
memory.c:996: warning: assignment makes pointer from integer without a
cast
make[2]: *** [memory.o] Error 1
make[2]: Leaving directory `/root/linux-2.5.14/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/root/linux-2.5.14/mm'
make: *** [_dir_mm] Error 2
[ ... ]

-Oliver


