Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSBKITW>; Mon, 11 Feb 2002 03:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287578AbSBKITL>; Mon, 11 Feb 2002 03:19:11 -0500
Received: from angband.namesys.com ([212.16.7.85]:4480 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S287532AbSBKITF>; Mon, 11 Feb 2002 03:19:05 -0500
Date: Mon, 11 Feb 2002 11:19:04 +0300
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Subject: unix sockets problems in 2.5.4-pre6?
Message-ID: <20020211111904.A955@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Just tried 2.5.4-pre6 and got hung postfix "master" process which I cannot
   kill in RUNNABLE state. Here is traces of all postfix processes at the time:

pickup        Z C212E180    48   522    520   523       (L-TLB)
Call Trace: [do_exit+745/784] [sys_exit+14/16] [syscall_call+7/11]
qmgr          S F70FBF30    48   523    520   524   522 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11]
tlsmgr        S F70F5F30  8944   524    520   523 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11]
master        R F773F744    48   520    900   524               (NOTLB)
Call Trace: [__write_lock_failed+9/32] [.text.lock.open+71/137] [unix_create+92/112] [sock_map_fd+12/304] [select_bits_free+10/16]
   [sys_socket+29/96] [sys_socket+48/96] [sys_socketcall+99/512] [syscall_call+7/11]

   Hope this will help someone to nail a problem

Bye,
    Oleg
