Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264151AbUECX3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbUECX3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUECX3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:29:16 -0400
Received: from pop.gmx.de ([213.165.64.20]:22741 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264151AbUECX3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:29:10 -0400
Date: Tue, 4 May 2004 01:29:09 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "lkml " <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Subject: acpi-20040326-2.6.6 on 2.6.6rc2 & KT400 (Epox 8k9a3+ )
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <27171.1083626949@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just wanted to report that i still have the
module unloading problem 

all Trace: [<c018ee8d>]  [<f8d5a1b5>]  [<f8d5a2d0>]  [<c01db097>] 
[<c01db155>]  [<f8d5a2ed>]  [<c0133078>]  [<c014dd6b>]  [<c014de13>] 
[<c0106029>]
Call Trace: [<c018ee8d>]  [<f8d6feda>]  [<f8d70197>]  [<c01db097>] 
[<c01db155>]  [<f8d701ad>]  [<c0133078>]  [<c014de13>]  [<c0106029>]
Call Trace: [<c018ee8d>]  [<f8d68229>]  [<f8d6854d>]  [<f8d68570>] 
[<c0133078>]  [<c014de13>]  [<c0106029>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c018ee8d <remove_proc_entry+16d/180>
Trace; f8d5a1b5 <__crc_bio_get_nr_vecs+2d1c5/49a18>
Trace; f8d5a2d0 <__crc_bio_get_nr_vecs+2d2e0/49a18>
Trace; c01db097 <acpi_driver_detach+3b/82>
Trace; c01db155 <acpi_bus_unregister_driver+14/57>
Trace; f8d5a2ed <__crc_bio_get_nr_vecs+2d2fd/49a18>
Trace; c0133078 <sys_delete_module+148/1a0>
Trace; c014dd6b <do_munmap+15b/1c0>
Trace; c014de13 <sys_munmap+43/70>
Trace; c0106029 <sysenter_past_esp+52/71>
Trace; c018ee8d <remove_proc_entry+16d/180>
Trace; f8d6feda <__crc_bio_get_nr_vecs+42eea/49a18>
Trace; f8d70197 <__crc_bio_get_nr_vecs+431a7/49a18>
Trace; c01db097 <acpi_driver_detach+3b/82>
Trace; c01db155 <acpi_bus_unregister_driver+14/57>
Trace; f8d701ad <__crc_bio_get_nr_vecs+431bd/49a18>
Trace; c0133078 <sys_delete_module+148/1a0>
Trace; c014de13 <sys_munmap+43/70>
Trace; c0106029 <sysenter_past_esp+52/71>
Trace; c018ee8d <remove_proc_entry+16d/180>
Trace; f8d68229 <__crc_bio_get_nr_vecs+3b239/49a18>
Trace; f8d6854d <__crc_bio_get_nr_vecs+3b55d/49a18>
Trace; f8d68570 <__crc_bio_get_nr_vecs+3b580/49a18>
Trace; c0133078 <sys_delete_module+148/1a0>
Trace; c014de13 <sys_munmap+43/70>
Trace; c0106029 <sysenter_past_esp+52/71>


2 warnings and 1 error issued.  Results may not be reliable.
[svetljo@svetljo svetljo]$

plus, 
acpi=noirq or pci=noacpi breaks usb 
/* hard to trace cause i've only usb keyboard */

acpi=off or acpi enabled seem to work,

but i've the impression that this patch breaks
irq assignment for my radeon both with 
acpi enabled or disabled
/* it's not listed in /proc/interupts
   and dri can not be activated       */

best,

svetljo

-- 
"Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
Jetzt aktivieren unter http://www.gmx.net/info

