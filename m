Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292338AbSCDNNW>; Mon, 4 Mar 2002 08:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292346AbSCDNNN>; Mon, 4 Mar 2002 08:13:13 -0500
Received: from marvin.nildram.co.uk ([195.112.4.71]:42514 "HELO
	marvin.nildram.co.uk") by vger.kernel.org with SMTP
	id <S292338AbSCDNNB>; Mon, 4 Mar 2002 08:13:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fernando Jimenez <fjimenez@roundcorners.com>
Reply-To: fjimenez@roundcorners.com
To: linux-kernel@vger.kernel.org
Subject: newbie Q: kernel BUG at vmalloc.c??
Date: Mon, 4 Mar 2002 13:17:54 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020304131308Z292338-889+117136@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I am coding a relatively simple (although it's proving quite hard) module for the linux kernel, and I have bumped into this!!

Mar  4 13:09:55 localhost kernel: kernel BUG at vmalloc.c:235!
Mar  4 13:09:55 localhost kernel: invalid operand: 0000
Mar  4 13:09:55 localhost kernel: CPU:    0
Mar  4 13:09:55 localhost kernel: EIP:    0010:[<c01320a6>]    Not tainted
Mar  4 13:09:55 localhost kernel: EFLAGS: 00000282
Mar  4 13:09:55 localhost kernel: eax: 0000001d   ebx: 0804b000   ecx: 00000001   edx: 000021ba
Mar  4 13:09:55 localhost kernel: esi: 0804aa20   edi: 00000000   ebp: c616ff98   esp: c616ff14
Mar  4 13:09:55 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar  4 13:09:55 localhost kernel: Process ioctl (pid: 1121, stackpage=c616f000)
Mar  4 13:09:55 localhost kernel: Stack: c028bf79 000000eb 00000002 00000001 00000282 00000001 c0350a64 00000246
Mar  4 13:09:55 localhost kernel:        00000024 c616ff98 0804aa20 0804aa20 00000000 c616ff98 c8829e08 0804aa20
Mar  4 13:09:55 localhost kernel:        000001f2 00000163 c013faed c585537c c5feb23c c68cdc94 c7d1a000 c13b396c
Mar  4 13:09:55 localhost kernel: Call Trace: [<c8829e08>] [<c013faed>] [<c0114906>] [<c0150706>] [<c01075bb>]
Mar  4 13:09:55 localhost kernel:
Mar  4 13:09:55 localhost kernel: Code: 0f 0b 5b 5e 31 c0 e9 a4 02 00 00 6a 02 53 e8 d7 fd ff ff 5a

I'm sure I must be doing something wrong somewhere, but the line "kernel BUG at vmalloc" does look worrying, 
and I don't quite know where it's comming from. I'm using kernel 2.4.17 on a RH7.2 box, and the ofending part of code is:

mdp_blks_use = vmalloc(mdp_blk_use_size * sizeof(char));

where mdp_blk_use_size is an integer, and I'm sure it's been set to something, and mdp_blks_use is a char pointer. 
I have used vmalloc in other parts of the code and it works fine. This is very confusing

Sorry if I'm doing something glaringly stupid here, still quite a newbie at kernel hacking. :) Thanks for your help
