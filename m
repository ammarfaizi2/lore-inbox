Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbTCQOV0>; Mon, 17 Mar 2003 09:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbTCQOV0>; Mon, 17 Mar 2003 09:21:26 -0500
Received: from pop.gmx.de ([213.165.64.20]:11078 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261403AbTCQOVZ>;
	Mon, 17 Mar 2003 09:21:25 -0500
Date: Mon, 17 Mar 2003 15:29:25 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Javier Achirica <achirica@telefonica.net>
Cc: tpepper@vato.org, jdthood0@yahoo.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-Id: <20030317152925.679bb16a.gigerstyle@gmx.ch>
In-Reply-To: <Pine.SOL.4.30.0303170227020.6371-100000@tudela.mad.ttd.net>
References: <20030316163358.A25887@jose.vato.org>
	<Pine.SOL.4.30.0303170227020.6371-100000@tudela.mad.ttd.net>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

next oops happened today with the latest cvs version

Device: wifi0
Mar 17 15:15:15 vaio kernel: Short packet 0
Mar 17 15:15:15 vaio kernel: Warning: kfree_skb passed an skb still on a list (from c0121fca).
Mar 17 15:15:15 vaio kernel: kernel BUG at skbuff.c:315!
Mar 17 15:15:15 vaio kernel: invalid operand: 0000
Mar 17 15:15:15 vaio kernel: CPU:    0
Mar 17 15:15:15 vaio kernel: EIP:    0010:[__kfree_skb+324/352]    Not tainted
Mar 17 15:15:15 vaio kernel: EIP:    0010:[<c026cd54>]    Not tainted
Mar 17 15:15:15 vaio kernel: EFLAGS: 00010286
Mar 17 15:15:15 vaio kernel: eax: 00000045   ebx: c3bcb9e0   ecx: cb392000   edx: cb393f7c
Mar 17 15:15:15 vaio kernel: esi: c1339f84   edi: 00000000   ebp: c1338000   esp: c1339f6c
Mar 17 15:15:15 vaio kernel: ds: 0018   es: 0018   ss: 0018
Mar 17 15:15:15 vaio kernel: Process keventd (pid: 2, stackpage=c1339000)
Mar 17 15:15:15 vaio kernel: Stack: c0314840 c0121fca 00000000 c1339f84 c0121fca c3bcb9e0 cd0942f8 cd0942f8
Mar 17 15:15:15 vaio kernel:        00000000 00000000 c012ac83 c032abd0 c1339fb0 00000000 c1338560 c1338570
Mar 17 15:15:15 vaio kernel:        c1338000 00000001 00000000 cffe5f90 00010000 00000000 00000700 c012ab50
Mar 17 15:15:15 vaio kernel: Call Trace:    [__run_task_queue+90/112] [__run_task_queue+90/112] [context_thread+307/448] [c
ontext_thread+0/448] [rest_init+0/64]
Mar 17 15:15:15 vaio kernel: Call Trace:    [<c0121fca>] [<c0121fca>] [<c012ac83>] [<c012ab50>] [<c0105000>]
Mar 17 15:15:15 vaio kernel:   [kernel_thread+46/64] [context_thread+0/448]
Mar 17 15:15:15 vaio kernel:   [<c010749e>] [<c012ab50>]
Mar 17 15:15:15 vaio kernel:
Mar 17 15:15:15 vaio kernel: Code: 0f 0b 3b 01 cf 2d 31 c0 8b 5c 24 14 e9 be fe ff ff 90 8d 76
Mar 17 15:16:34 vaio kernel:  <3>airo: BAP setup error too many retries
Mar 17 15:16:59 vaio kernel: mtrr: no MTRR for fd000000,400000 found
Mar 17 15:17:10 vaio kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync showTasks Unmoun
t


On Mon, 17 Mar 2003 02:28:58 +0100 (MET)
Javier Achirica <achirica@telefonica.net> wrote:

> 
> I'm aware of this "lock up" problem. I was hoping it was a locking issue
> and the last changes would solve it. Looks like not. The biggest problem
> I'm having with that issue is that I'm not able to reproduce it. Any
> suggestion?
> 
> Javier Achirica
