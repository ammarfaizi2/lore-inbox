Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSHGSTS>; Wed, 7 Aug 2002 14:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318791AbSHGSTS>; Wed, 7 Aug 2002 14:19:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:35247 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318787AbSHGSTP>;
	Wed, 7 Aug 2002 14:19:15 -0400
Message-ID: <3D516428.5070005@illich.cz>
Date: Wed, 07 Aug 2002 20:17:12 +0200
From: Michal Illich <michal@illich.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 crash
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

	I want to report multiple crashes while using last stable kernel, the message 
it gives is:

--------------------
Unable to handle kernel paging request at virtual address 45ca6234
  printing eip:
c0128c80
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0128c80>]    Not tainted
EFLAGS: 00010813
eax: 999f7887   ebx: c2217e50   ecx: df4c8000   edx: f762e680
esi: 00000246   edi: cfbc4380   ebp: 000000f0   esp: ddff7de8
ds: 0018   es: 0018   ss: 0018
Process NameOfProccessWhichWasRunning (pid: 2133, stackpage=ddff7000)
Stack: 00000000 ecb0109c 009bb6d0 e55216c0 00000000 00000000 00001000 00000001
        c0132804 c2217e50 000000f0 c01328b6 00000001 df4c8940 04a87241 00000000
        0000a324 c212b320 00000341 0000a325 c212b320 c0132ae6 c212b320 00001000
Call Trace:    [<c0132804>] [<c01328b6>] [<c0132ae6>] [<c0133158>] [<c01239ad>]
   [<c0123a47>] [<c01534f0>] [<c0124035>] [<c0124288>] [<c0126408>] [<c01247fa>]
--------------------

	Then it refuses to do "anything reasonable" (probably forking a new thread), 
but ping works and some applications are partially running (e.g. Apache 
serves static page, but not CGI). No user can log in.

	It prints the message above multiple times, probably at each atempt to do 
something. Sometimes (not the first time) it also writes "Bug: ... twice..." 
(I don't remember it, sorry, it isn't written in messages).

	On the machine are large blocks of shared memory (hundreds of MB, usually 
larger than default SHMMAX, which is now set to 256MB), crash happened while 
processing large amounts of data (few GB, hundreds of MB RAM used).

	Other info: Red Hat Linux 7.3, kernel 2.4.19 from kernel.org, single Athlon 
XP, compiled with Athlon processor option and "4GB" memory setting.

         If you need more information, feel free to ask me. Do you know what 
happened and if it can be fixed?

	Thanks,

Michal Illich





