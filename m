Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSICNay>; Tue, 3 Sep 2002 09:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSICNay>; Tue, 3 Sep 2002 09:30:54 -0400
Received: from employees.nextframe.net ([212.169.100.200]:248 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S318774AbSICNax>; Tue, 3 Sep 2002 09:30:53 -0400
Date: Tue, 3 Sep 2002 15:36:36 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.33] bad: schedule() with irqs disabled!
Message-ID: <20020903153636.A1415@sexything>
Reply-To: morten.helgesen@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys, 

got this one on my Inspiron 2500 - and still can`t see
a fix in Linus` bk-tree. Do people agree that do_softirq() is
the bad guy ? Anyone looking into this ? I haven`t got the time
right now as I am both trying to figure out the qlogicisp.c mess 
and trying to get a working i81x framebuffer in 2.5.33. But I do 
think it is time we get it fixed.

bad: schedule() with irqs disabled!
c1c05e2c c025c540 c11605e0 c1c05e54 c0111fd8 00000005 c03139d8 fffffffa
c1c05e50 00000046 c1c05e64 c0111fef c11605e0 00000000 c03139c0 c011a170
c1c04000 00000004 00000000 00000000 00000246 c022e5c0 c02e9460 00000004

Call Trace: 
[try_to_wake_up+256/268]
[wake_up_process+11/16]
[do_softirq+160/172]
[tcp_recvmsg+2124/2372]
[inet_recvmsg+61/84]
[_recvfrom+144/272]
[smb_get_length+22/172]
[smb_receive_header+69/236]
[smb_request_recv+106/462]
[smbiod_doio+28/160]
[smbiod+358/436]
[smbiod+0/436]
[default_wake_function+0/52]
[kernel_thread_helper+5/12]

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
