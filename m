Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbRFENul>; Tue, 5 Jun 2001 09:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263981AbRFENuc>; Tue, 5 Jun 2001 09:50:32 -0400
Received: from [217.27.32.7] ([217.27.32.7]:33091 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S263979AbRFENuZ>;
	Tue, 5 Jun 2001 09:50:25 -0400
Date: Tue, 5 Jun 2001 16:43:35 +0300
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.5[-ac8] warnings while compiling
Message-ID: <20010605164335.A21678@francoudi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010605154744.A13643@francoudi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010605154744.A13643@francoudi.com>; from leonid@francoudi.com on Tue, Jun 05, 2001 at 03:47:45PM +0300
X-Operating-System: Linux leonid.francoudi.com 2.4.3
X-Uptime: 4:39pm  up 7 days,  7:34, 15 users,  load average: 0.07, 0.67, 1.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Leonid Mamtchenkov,

Once you wrote about "linux-2.4.5[-ac8] warnings while compiling":
LM> While compile kernel 2.4.5 or 2.4.5-ac8 I get lots of warning, which look like
LM> this:
LM> ---- kernel.stderr start ----
LM> In file included from /usr/src/linux-2.4.5-ac8/include/linux/raid/md.h:51,
LM>                  from init/main.c:25:

<skip>
LM> /usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:21:33: warning: "__ver_proc_root_driver" redefined
LM> /usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:21:1: warning: this is the location of the previous definition
LM> ----- kernel.stderr end -----

Sorry for replying to myself, but the problem can be solved by doing
"make mrproper" (thanks to Bill Pringlemeir).

Now I am left only with following warnings, in case someone is interested.
---- start kernel.stderr.1 ----
In file included from /usr/src/linux-2.4.5-ac8/include/linux/raid/md.h:51,
                 from init/main.c:25:
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h:41: warning: control reaches end of non-void function
In file included from /usr/src/linux-2.4.5-ac8/include/linux/raid/md.h:51,
                 from ll_rw_blk.c:31:
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h:41: warning: control reaches end of non-void function
{standard input}: Assembler messages:
{standard input}:64: Warning: indirect lcall without `*'
{standard input}:134: Warning: indirect lcall without `*'
{standard input}:186: Warning: indirect lcall without `*'
In file included from /usr/src/linux-2.4.5-ac8/include/linux/raid/md.h:51,
                 from check.c:22:
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h:41: warning: control reaches end of non-void function
dmi_scan.c:161: warning: `disable_ide_dma' defined but not used
pci-pc.c:952: warning: `pci_fixup_via691' defined but not used
pci-pc.c:965: warning: `pci_fixup_via691_2' defined but not used
{standard input}: Assembler messages:
{standard input}:784: Warning: indirect lcall without `*'
{standard input}:869: Warning: indirect lcall without `*'
{standard input}:955: Warning: indirect lcall without `*'
{standard input}:993: Warning: indirect lcall without `*'
{standard input}:1025: Warning: indirect lcall without `*'
{standard input}:1057: Warning: indirect lcall without `*'
{standard input}:1088: Warning: indirect lcall without `*'
{standard input}:1117: Warning: indirect lcall without `*'
{standard input}:1146: Warning: indirect lcall without `*'
{standard input}:1433: Warning: indirect lcall without `*'
{standard input}:1529: Warning: indirect lcall without `*'
fault.c:123: warning: `print_pagetable_entries' defined but not used
bbootsect.s: Assembler messages:
bbootsect.s:257: Warning: indirect lcall without `*'
bsetup.s: Assembler messages:
bsetup.s:1374: Warning: indirect lcall without `*'
Root device is (3, 2)
Boot sector 512 bytes.
Setup is 4532 bytes.
System is 669 kB
----- end kernel.stderr.1 -----

-- 
 Best regards,
 Leonid Mamtchenkov
 System Administrator

