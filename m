Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTEEQbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTEEQbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:31:44 -0400
Received: from franka.aracnet.com ([216.99.193.44]:53963 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263671AbTEEQ25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:28:57 -0400
Date: Mon, 05 May 2003 09:40:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 656] New: Uninitialized timer on module mga
Message-ID: <11400000.1052152853@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=656

           Summary: Uninitialized timer on module mga
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: s.rivoir@gts.it


Distribution: debian unstable 
Hardware Environment: 
Software Environment: 
Problem Description: Uninitialized timer in module mga 
 
Steps to reproduce: 
just insert the module 
 
Call trace: 
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.  
Uninitialised timer!  
This is just a warning.  Your computer is OK  
function=0x00000000, data=0x0  
Call Trace:  
[check_timer_failed+97/112] check_timer_failed+0x61/0x70  
[del_timer+26/128] del_timer+0x1a/0x80  
[<d09a4270>] mga_takedown+0x50/0x380 [mga]  
[<d09a90ef>] mga_stub_unregister+0x2f/0x4b [mga]  
[<d08d1235>] +0x235/0x25d [mga]  
[<d09adc6c>] __func__.31+0x0/0x9 [mga]  
[<d09baa00>] +0x0/0x140 [mga]  
[sys_init_module+303/480] sys_init_module+0x12f/0x1e0  
[<d09baa00>] +0x0/0x140 [mga]  
[syscall_call+7/11] syscall_call+0x7/0xb


