Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbTGHXDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267873AbTGHXDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:03:05 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:34463 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267864AbTGHXC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:02:59 -0400
Subject: Re: 2.5.74-mm2 [kernel BUG at include/linux/list.h:148!]
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030708004350.GA16488@matchmail.com>
References: <20030705132528.542ac65e.akpm@osdl.org>
	 <1057455650.3119.3.camel@debian> <20030706134926.GA472@nikolas.hn.org>
	 <20030708004350.GA16488@matchmail.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1057706251.922.1.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 01:17:32 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same bug message, again:

kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0118599>]    Not tainted VLI
EFLAGS: 00010087
eax: c2a0fe34   ebx: cb45a000   ecx: c2a0fe34   edx: cb45beb0
esi: cb45bea4   edi: 00000246   ebp: c67fc400   esp: cb45be6c
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 6484, threadinfo=cb45a000 task=ce4eed40)
Stack: c2a0fe34 cb45bea4 cb45a000 c0193e05 c2a0fe30 c12d3b60 00000000
ce4eed40 
       c0116f20 00000000 00000000 bffff000 c79cb5e0 c12218e8 00000000
ce4eed40 
       c0116f20 c2a0fe34 c2a0fe34 c93b1005 000056ed 00000001 c67fc400
cb45bf70 
Call Trace: [<c0193e05>]  [<c0116f20>]  [<c0116f20>]  [<c0156924>] 
[<c0156dae>]
  [<c0157a2a>]  [<c014892c>]  [<c0148db9>]  [<c0108f47>] 
Code: 20 00 c7 46 0c 00 01 10 00 57 9d ff 4b 14 8b 43 08 a8 08 75 04 5b
5e 5f c3
 5b 5e 5f e9 31 e9 ff ff 0f 0b 95 00 e4 be 24 c0 eb cb <0f> 0b 94 00 e4
be 24 c0
 eb b9 90 90 90 90 90 90 90 90 90 90 90 
 <6>note: syslogd[6484] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace: [<c0116ea0>]  [<c013bb2e>]  [<c013f522>]  [<c011894e>] 
[<c011c44d>]
  [<c0109a20>]  [<c01097d3>]  [<c0109ab1>]  [<c0118599>]  [<c0130259>] 
[<c01621
8e>]  [<c01307f8>]  [<c01091ad>]  [<c0118599>]  [<c0193e05>] 
[<c0116f20>]  [<c0
116f20>]  [<c0156924>]  [<c0156dae>]  [<c0157a2a>]  [<c014892c>] 
[<c0148db9>]  
[<c0108f47>] 
psmouse.c: Lost synchronization, throwing 3 bytes away.

-- 
/================================================\
| Ramón Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\================================================/

