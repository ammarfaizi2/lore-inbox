Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUCLPq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUCLPoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:44:18 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:42632 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S262213AbUCLPno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:43:44 -0500
Message-ID: <4051DAAC.9000603@steudten.com>
Date: Fri, 12 Mar 2004 16:43:40 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Badness in kernel 2.6.4 SG/SCSI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I got this from 2.6.4 kernel first after boot:

Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Badness in kobject_get at lib/kobject.c:429
fffffc0013947d98 0000000000000000 fffffc00004ace54 0000000000000001
        fffffc000037c564 0000000000000001 fffffc001cb1a8c0 0000000001500001
        fffffc0013947e08 0000000000000000 fffffffc00234fe4 0000000000000001
        0000000000000000 fffffffc001aa000 0000000001500001 0000000000000000
        0000000000000000 fffffc001e7d4388 fffffc00004f2b78 fffffc00001251f0
        fffffffc0023d260 fffffc0000731ef0 fffffc0000731f88 fffffc0000731f70
Trace:fffffc00004ace54 fffffc000037c564 fffffc00004f2b78 fffffc00004f1fd0
fffffc0000533154 fffffc0000346018 fffffc0000312b84
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Badness in kobject_get at lib/kobject.c:429
fffffc0013947d98 0000000000000000 fffffc00004ace54 0000000000000002
        fffffc000037c564 0000000000000002 fffffc001cb1a828 0000000001500002
        fffffc0013947e08 0000000000000000 fffffffc00234fe4 0000000000000002
        0000000000000000 fffffffc001ae000 0000000001500002 0000000000000000
        0000000000000000 fffffc001e7d4388 fffffc00004f2b78 fffffc0000125e38
        fffffffc0023d260 fffffc0000731ef0 fffffc0000731f88 fffffc0000731f70
Trace:fffffc00004ace54 fffffc000037c564 fffffc00004f2b78 fffffc00004f1fd0
fffffc0000533154 fffffc0000346018 fffffc0000312b84
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
Badness in kobject_get at lib/kobject.c:429
fffffc0013947d98 0000000000000000 fffffc00004ace54 0000000000000003
        fffffc000037c564 0000000000000003 fffffc001cb1a790 0000000001500003
        fffffc0013947e08 0000000000000000 fffffffc00234fe4 0000000000000003
        0000000000000000 fffffffc001b2000 0000000001500003 0000000000000000
        0000000000000000 fffffc001e7d4388 fffffc00004f2b78 fffffc0000126db8
        fffffffc0023d260 fffffc0000731ef0 fffffc0000731f88 fffffc0000731f70
Trace:fffffc00004ace54 fffffc000037c564 fffffc00004f2b78 fffffc00004f1fd0
fffffc0000533154 fffffc0000346018 fffffc0000312b84
Attached scsi generic sg3 at scsi0, channel 0, id 3, lun 0,  type 0


Trace; fffffc00004ace54 <kobject_rename+64/80>
Trace; fffffc000037c564 <base_probe+4/a0>
Trace; fffffc00004acca8 <kobject_set_name+38/180>
Trace; fffffc00004f2b78 <class_simple_destroy+48/60>
Trace; fffffc00004f1fd0 <class_dev_release+50/b0>
Trace; fffffc0000533154 <scsi_sysfs_register+64/a0>
Trace; fffffc0000346018 <module_address_lookup+78/c0>
Trace; fffffc0000312b84 <entSys+a4/c0>
Trace; fffffc00004ace54 <kobject_rename+64/80>
Trace; fffffc000037c564 <base_probe+4/a0>
Trace; fffffc00004f2b78 <class_simple_destroy+48/60>
Trace; fffffc00004f1fd0 <class_dev_release+50/b0>
Trace; fffffc0000533154 <scsi_sysfs_register+64/a0>
Trace; fffffc0000346018 <module_address_lookup+78/c0>
Trace; fffffc0000312b84 <entSys+a4/c0>
Trace; fffffc00004ace54 <kobject_rename+64/80>
Trace; fffffc000037c564 <base_probe+4/a0>
Trace; fffffc00004f2b78 <class_simple_destroy+48/60>
Trace; fffffc00004f1fd0 <class_dev_release+50/b0>
Trace; fffffc0000533154 <scsi_sysfs_register+64/a0>
Trace; fffffc0000346018 <module_address_lookup+78/c0>
Trace; fffffc0000312b84 <entSys+a4/c0>
Trace; fffffc00004ace54 <kobject_rename+64/80>
Trace; fffffc000037c564 <base_probe+4/a0>
Trace; fffffc00004f2b78 <class_simple_destroy+48/60>
Trace; fffffc00004f1fd0 <class_dev_release+50/b0>
Trace; fffffc0000533154 <scsi_sysfs_register+64/a0>
Trace; fffffc0000346018 <module_address_lookup+78/c0>
Trace; fffffc0000312b84 <entSys+a4/c0>

00:07.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
         Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
         Flags: bus master, medium devsel, latency 32, IRQ 26
         I/O ports at 8400 [size=256]
         Memory at 000000000a051000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at 000000000a040000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 1

Can anyone please fix this in the kernel code.
-- 
Tom





