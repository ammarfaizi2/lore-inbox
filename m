Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSLVWNG>; Sun, 22 Dec 2002 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSLVWNF>; Sun, 22 Dec 2002 17:13:05 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:61830 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S265475AbSLVWNF>;
	Sun, 22 Dec 2002 17:13:05 -0500
Date: Sun, 22 Dec 2002 23:21:08 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Message-ID: <20021222222108.GA2482@werewolf.able.es>
References: <200212221439.28075.m.c.p@wolk-project.de> <200212221538.32354.m.c.p@wolk-project.de> <200212221557.11563.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200212221557.11563.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Sun, Dec 22, 2002 at 15:57:11 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.22 Marc-Christian Petersen wrote:
>On Sunday 22 December 2002 15:38, Marc-Christian Petersen wrote:
>
>And hi again ^3,
>
>> root@codeman:[/] # uname -r
>> 2.4.20-rmap15b
>> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
>> 131072+0 records in
>> 131072+0 records out
>> 2147483648 bytes transferred in 140.460427 seconds (15288887 bytes/sec)
>
>root@codeman:[/] # uname -r
>2.4.20aa1
>root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
>131072+0 records in
>131072+0 records out
>2147483648 bytes transferred in 286.054011 seconds (7507266 bytes/sec)
>

Check you timer...

werewolf:~> uname -a
Linux werewolf.able.es 2.4.20-jam2 #2 SMP vie dic 20 22:35:33 CET 2002 i686 unknown unknown GNU/Linux
werewolf:~> time dd if=/dev/zero of=kk bs=16384 count=131072
131072+0 records in
131072+0 records out
0.51user 60.63system 1:23.73elapsed 73%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (133major+15minor)pagefaults 0swaps

Box is a dual PII@400, 950Mb of RAM. FS is ext3.
So about 83 seconds on -jam2, which is mainly just 2.4.20aa1 with ext3 fixes.
Ah, no special options to ext3 mount (no  data=ordered). That's the point ?

???

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
