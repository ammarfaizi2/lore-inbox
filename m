Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbUDPPvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUDPPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:51:21 -0400
Received: from tag.witbe.net ([81.88.96.48]:21007 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263274AbUDPPvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:51:14 -0400
Message-Id: <200404161551.i3GFpD124970@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.6.5] Bad scheduling while atomic
Date: Fri, 16 Apr 2004 17:51:11 +0200
Organization: Witbe
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjyqOncQWA6WEBSXKY/omSX5eGOA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have these in my logs :

bad: scheduling while atomic!
Call Trace:
 [<c011aa54>] schedule+0x59e/0x5a4
 [<c0118575>] pte_alloc_one+0x55/0x68
 [<c011ad6d>] wait_for_completion+0x91/0xe6
 [<c011aaaa>] default_wake_function+0x0/0x12
 [<c011aaaa>] default_wake_function+0x0/0x12
 [<c012dc05>] synchronize_kernel+0x31/0x3c
 [<c012dbca>] wakeme_after_rcu+0x0/0xa
 [<c04131ef>] unregister_netdevice+0x141/0x27a
 [<c0419f8b>] rtmsg_ifinfo+0x91/0xda
 [<c03316c8>] lapbeth_device_event+0xa6/0xf0
 [<c0129dc5>] notifier_call_chain+0x27/0x3e
 [<c041320f>] unregister_netdevice+0x161/0x27a
 [<c0330cf2>] tun_chr_close+0xe8/0xf2
 [<c0330c0a>] tun_chr_close+0x0/0xf2
 [<c0153340>] __fput+0x120/0x132
 [<c015199b>] filp_close+0x59/0x86
 [<c0151a2c>] sys_close+0x64/0x98
 [<c0108b17>] syscall_call+0x7/0xb

Any other info that could help someone ?

Regards,
Paul


