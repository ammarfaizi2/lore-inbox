Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUBDC0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUBDC0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:26:11 -0500
Received: from [200.115.201.252] ([200.115.201.252]:26374 "EHLO
	reloco.dhis.org") by vger.kernel.org with ESMTP id S265987AbUBDC0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:26:08 -0500
Message-ID: <4020583D.7050605@hotmail.com>
Date: Tue, 03 Feb 2004 23:26:05 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Lichtmaier?= <niqueco@hotmail.com>
Reply-To: jnl@synapsis-sa.com.ar
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.6.1's PPP? Stack trace included.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to build a tunnel with ppp+ssh I've been getting ESRCH whith 
ping. And these kernel messages:

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c01206e4>] local_bh_enable+0x70/0x72
 [<d009baac>] ppp_async_push+0x88/0x151 [ppp_async]
 [<d009b402>] ppp_asynctty_wakeup+0x2d/0x5e [ppp_async]
 [<c01c189f>] pty_unthrottle+0x58/0x5a
 [<c01be685>] check_unthrottle+0x39/0x3b
 [<c01be6f6>] n_tty_flush_buffer+0x13/0x55
 [<c01c1c5a>] pty_flush_buffer+0x66/0x68
 [<c01bb5a1>] do_tty_hangup+0x3a3/0x3f0
 [<c01bc861>] release_dev+0x665/0x691
 [<c013ce45>] zap_pmd_range+0x47/0x61
 [<c013cea2>] unmap_page_range+0x43/0x69
 [<c01bcbd5>] tty_release+0xf/0x15
 [<c014b1f6>] __fput+0xdd/0xef
 [<c0149b6f>] filp_close+0x59/0x86
 [<c011e360>] put_files_struct+0x84/0xe9
 [<c011eee4>] do_exit+0x14f/0x32f
 [<c011f145>] do_group_exit+0x34/0x72
 [<c0108f75>] sysenter_past_esp+0x52/0x71
 
Badness in local_bh_enable at kernel/softirq.c:121

I hope it helps.

Thanks.
