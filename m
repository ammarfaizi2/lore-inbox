Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUGTEON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUGTEON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 00:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUGTEON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 00:14:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:5031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265509AbUGTEOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 00:14:07 -0400
Date: Mon, 19 Jul 2004 21:07:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Nicolas Ross" <rossnick-lists@cybercat.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference
Message-Id: <20040719210706.0ccdeb80.rddunlap@osdl.org>
In-Reply-To: <033601c46dc5$dd5470a0$1a07a8c0@civic2k>
References: <033601c46dc5$dd5470a0$1a07a8c0@civic2k>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2004 15:23:25 -0400 Nicolas Ross wrote:

| Hi all !
| 
| I have a firewall box, with a vanilla kernel from kernel.org. I've tried
| with 2.4.19 and 2.4.24. The system is RedHat 7.3 (it does the same thing
| with 8.0, and gcc 3)
| 
| The kernel is pretty straigh-up, not much options, some net modules,
| iptables etc.
| 
| The only thing out of the ordinary is a custom net/core/dev.c file to
| support a bandwith management module, wich isn't gpl and is pre-compiled.
| 
| When issuing commands to configure the bandwith manager, I get :
| 
| Unable to handle kernel NULL pointer dereference at virtual address 00000000
|  printing eip:
| 00000000
| *pde = 00000000
| Oops: 0000
| CPU:    0
| EIP:    0010:[<00000000>]    Tainted: P

What module makes it tainted?  Can you reproduce problem without it?

| EFLAGS: 00010086
| eax: ddf5f948   ebx: ddf5e000   ecx: ddf5f980   edx: de9db400
| esi: c0000000   edi: ddf5f986   ebp: ddf5f9b8   esp: ddf5f92c
| ds: 0018   es: 0018   ss: 0018
| Process bwmgr (pid: 1120, stackpage=ddf5f000)
| Stack: e08c4431 de9db400 ddf5f980 00008946 fffffec4 11860f1f 00000000
| 0000000a
|        00000000 00000001 00000000 00000000 00000000 00000000 00000000
| 00000000
|        00000000 00bd0c00 00000000 00000000 90c8ebff 6e616c76 e08d0032
| defec800
| Call Trace:    [<e08c4431>] [<e08d0032>] [<e08d58d7>] [<e08d68b5>]
| [<c012b346>]
|   [<c0120ea3>] [<c012b346>] [<c012995a>] [<c0120ea3>] [<c0120f19>]
| [<c010f303>]
|   [<c028407e>] [<e08d95f6>] [<c01216de>] [<c010f1b0>] [<c01071b4>]
| [<c0282bab>]
|   [<c010f1b0>] [<c01071b4>] [<c0282bab>] [<e08af1f7>] [<e08c33ec>]
| [<c01a3a17>]
|   [<c023af54>] [<c023b138>] [<c023315a>] [<c013e413>] [<c01070a3>]
| 
| Code:  Bad EIP value.
| 
| After that the system still responds but isn't much usable, I have to
| reboot, not practicall...
| 
| All of this was working with the exact same setup, but on a different MB,
| and kernel 2.4.19.
| 
| Any hints on the source of this exception ?

Please run this oops message thru ksymoops and resend it.
See linux/Documentation/ oops-tracing.txt for details.

--
~Randy
