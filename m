Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUAACYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 21:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUAACYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 21:24:50 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:46724 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S265328AbUAACYs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 21:24:48 -0500
Date: Thu, 1 Jan 2004 03:24:48 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Irda oops with 2.6.0
Message-ID: <20040101022448.GA812@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got following oops while usiing irda with my laptop. I'm using nsc-ircc
driver.

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c0121065>] local_bh_enable+0x8c/0x8e
 [<c02aa3c3>] dev_queue_xmit+0x224/0x2b9
 [<d08fc13f>] irlap_send_data_primary_poll+0xc9/0x184 [irda]
 [<d08f9aec>] irlap_state_xmit_p+0x1bf/0x240 [irda]
 [<d08f8f2d>] irlap_do_event+0xef/0x186 [irda]
 [<d08f7c39>] irlap_data_request+0xf2/0x124 [irda]
 [<d08f6ee4>] irlmp_state_dtr+0x100/0x194 [irda]
 [<d08f6707>] irlmp_do_lsap_event+0x3f/0x41 [irda]
 [<d08f5413>] irlmp_disconnect_request+0xa0/0x17f [irda]
 [<d08ffeee>] irttp_disconnect_request+0xdd/0x16f [irda]
 [<d08d2a15>] ircomm_state_conn+0x96/0xca [ircomm]
 [<d08d2a74>] ircomm_do_event+0x2b/0x2f [ircomm]
 [<d08d256d>] ircomm_disconnect_request+0x42/0x44 [ircomm]
 [<d08b1830>] ircomm_tty_state_ready+0x4b/0xc3 [ircomm_tty]
 [<d08b18ee>] ircomm_tty_do_event+0x46/0x48 [ircomm_tty]
 [<d08b0b88>] ircomm_tty_detach_cable+0x7e/0xdc [ircomm_tty]
 [<d08afff5>] ircomm_tty_shutdown+0xb0/0xf9 [ircomm_tty]
 [<d08af73b>] ircomm_tty_close+0x108/0x20c [ircomm_tty]
 [<c01e07db>] release_dev+0x733/0x77e
 [<c01df7c7>] tty_write+0x1a3/0x2be
 [<c01e0baf>] tty_release+0x2e/0x67
 [<c0151f75>] __fput+0x118/0x12a
 [<c015065d>] filp_close+0x57/0x81
 [<c01506eb>] sys_close+0x64/0x96
 [<c010a343>] syscall_call+0x7/0xb

-- 
Luká¹ Hejtmánek
