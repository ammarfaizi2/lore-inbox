Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbULSXKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbULSXKe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 18:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULSXKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 18:10:34 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:19426 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261352AbULSXKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 18:10:20 -0500
Date: Mon, 20 Dec 2004 00:10:15 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Scheduling while atomic (2.6.10-rc3-bk13)
Message-ID: <20041219231015.GB4166@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when suspending to disk I got:
scheduling while atomic: suspenddisk.sh/0x00000001/1452
[<c031dc81>] schedule+0x4b3/0x563
[<c031e170>] schedule_timeout+0x5d/0xab
[<c011e9e5>] process_timeout+0x0/0x9
[<c011edbd>] msleep+0x2c/0x34
[<df8303cb>] ehci_hub_resume+0xed/0x1de [ehci_hcd]
[<c025885f>] usb_resume_device+0x80/0xc7
[<c021dc2e>] dpm_resume+0xa2/0xa4
[<c021dc41>] device_resume+0x11/0x1e
[<c0130485>] finish+0x8/0x3a
[<c013058e>] pm_suspend_disk+0x3e/0x73
[<c012ecfa>] enter_state+0x6e/0x72
[<c012ee18>] state_store+0xa4/0xb7
[<c0184441>] subsys_attr_store+0x34/0x3d
[<c01846c0>] flush_write_buffer+0x3e/0x4a
[<c018473b>] sysfs_write_file+0x6f/0x7e
[<c01846cc>] sysfs_write_file+0x0/0x7e
[<c01504ec>] vfs_write+0xf4/0x12f
[<c014fa31>] filp_close+0x52/0x96
[<c01505f8>] sys_write+0x51/0x80
[<c010306f>] syscall_call+0x7/0xb

-- 
Luká¹ Hejtmánek
