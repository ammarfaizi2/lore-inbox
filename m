Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUAATff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 14:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUAATff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 14:35:35 -0500
Received: from mail3.edisontel.com ([62.94.0.36]:37054 "EHLO
	mail3.edisontel.com") by vger.kernel.org with ESMTP id S264542AbUAATf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 14:35:26 -0500
From: "Eduard <master^shadow> Roccatello" 
	<lilo.please.no.spam@roccatello.it>
Organization: SPINE
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel NULL pointer dereference
Date: Thu, 1 Jan 2004 19:44:50 +0100
User-Agent: KMail/1.5.3
X-IRC: #hardware@azzurra.org #rolug@freenode
X-Jabber: eduardroccatello@jabber.linux.it
X-GPG-Keyserver: keyserver.linux.it
X-GPG-FingerPrint: F7B3 3844 038C D582 2C04 4488 8D46 368B 474D 6DB0
X-GPG-KeyID: 474D6DB0
X-Website: http://www.pcimprover.it
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401011944.51109.lilo.please.no.spam@roccatello.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

i got an oops on USB mouse disconnect. i have tried to reproduce the oops 
but it happened only once. I'm running 2.6.0 vanilla with nvidia binary 
drivers but they not seems to be involved in the oops (imho).
USB modules i use are: hid, hcd-ohci, hcd-ehci

This his the oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c01636fb
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01636fb>]    Tainted: PF 
EFLAGS: 00010292
EIP is at __lookup_hash+0x1b/0xd0
eax: dfdcdeb8   ebx: 12fd28db   ecx: ffffffff   edx: 01b9ec71
esi: c03d0bb8   edi: 00000000   ebp: 00000000   esp: dfdcde7c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=dfdcc000 task=c151c080)
Stack: 00000246 000003e8 e194d6be 12fd28db c03d0bb8 c0366258 dbf7d624 
c01637cf 
       dfdcdeb8 00000000 00000000 c018930c dfdcdeb8 00000000 0000001e 
c0366253 
       00000005 12fd28db dd93e380 dd93e294 dbf7d600 c018a85f 00000000 
c0366253 
Call Trace:
 [<e194d6be>] ed_free+0x24/0x28 [ohci_hcd]
 [<c01637cf>] lookup_hash+0x1f/0x23
 [<c018930c>] sysfs_get_dentry+0x6a/0x70
 [<c018a85f>] sysfs_remove_group+0x65/0x6a
 [<c0243e6e>] dpm_sysfs_remove+0x1a/0x20
 [<c0243937>] device_pm_remove+0x26/0x71
 [<c0241487>] device_del+0x65/0x9b
 [<c028c165>] usb_disable_device+0x71/0xac
 [<c02869d6>] usb_disconnect+0x9b/0xe6
 [<c0288ffa>] hub_port_connect_change+0x31d/0x322
 [<c0288916>] hub_port_status+0x45/0xb0
 [<c0289338>] hub_events+0x339/0x39e
 [<c02893ca>] hub_thread+0x2d/0xe3
 [<c0109032>] ret_from_fork+0x6/0x14
 [<c011b420>] default_wake_function+0x0/0x12
 [<c028939d>] hub_thread+0x0/0xe3
 [<c01070c9>] kernel_thread_helper+0x5/0xb

Code: 8b 77 08 c7 44 24 04 01 00 00 00 89 6c 24 08 89 34 24 e8 d4 
 

Thanks for the attention (and sorry for my english)
See you
--
Eduard Roccatello
S.P.I.N.E. Group

