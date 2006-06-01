Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWFAWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWFAWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWFAWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:23:27 -0400
Received: from c-71-234-110-81.hsd1.ct.comcast.net ([71.234.110.81]:23774 "EHLO
	h.klyukin.com") by vger.kernel.org with ESMTP id S1750789AbWFAWX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:23:26 -0400
Message-ID: <447F68D8.5000602@klyukin.com>
Date: Thu, 01 Jun 2006 18:23:20 -0400
From: Yaroslav Klyukin <slava@klyukin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "amd76xrom" amd76xrom_init_one(): Unable to register resource 0xffc00000-0xffffffff
 - kernel bug?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The box has over 12G of ram on an opteron architecture and because of that the SCSI driver fails to
load:


SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
"amd76xrom" amd76xrom_init_one(): Unable to register resource 0xffc00000-0xffffffff - kernel bug?
Found: PMC Pm49FL004
"amd76xrom" @fff80000: Found 1 x8 devices at 0x0 in 8-bit bank
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Unable to handle kernel NULL pointer dereference at 00000000000001f8 RIP:
<ffffffff8039aba1>{map_destroy+1}
PGD 0
Oops: 0000 [1] SMP
last sysfs file:
CPU 3
Pid: 1, comm: swapper Not tainted 2.6.16.13-4-dem 48 8b 40 78 48 8b 40 08 48 85
RIP <ffffffff8039aba1>{map_destroy+1} RSP <ffff8103ffc41f18>
CR2: 00000000000001f8
 <0>Kernel panic - not syncing: Attempted to kill init!


If I boot with mem=1024m , it boots.

Ideas would be highly appreciated!
