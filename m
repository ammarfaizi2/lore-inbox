Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310963AbSCHROp>; Fri, 8 Mar 2002 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310961AbSCHROe>; Fri, 8 Mar 2002 12:14:34 -0500
Received: from romulus.cl.urbanweb.net ([209.53.118.29]:62343 "HELO
	romulus.triluminary.net") by vger.kernel.org with SMTP
	id <S310960AbSCHROP>; Fri, 8 Mar 2002 12:14:15 -0500
Date: Mon, 4 Mar 2002 18:07:44 -0800
From: "Timothy M. Totten" <novus@triluminary.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel Errors Part 2
Message-ID: <20020304180744.A339@romulus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a followup to the note I sent you
about the errors I am getting with the kernel.
Here is a glimpse of what 2.4.18 is telling me.
I really have to figure out how to do a dump
of the kernel panic errors as writing this sucker
out by hand was a pain in the arse :-)

--- begin error thingy

Unable to handle kernel paging request at virtual address 2c018218
Printing eip:
c01ae528
*pde=00000000
Oops: 0000
CPU:  3
EIP: 0010:[<c01ae528>]  Not tainted
EFLAGS: 00010282
eax: c2c38000 ebx: 2c018200 ecx: 00000000 edx: 00000000
esi: f880c274 edi: f7b5fc00 ebp: f7b5fc00 esp: c2c39c64
ds: 0018 es: 0018 ss: 0018
Process swapper (pid:1, stackpage=c2c39000)
Stack: 00000000 f88c274 f765fc00 00000000 f882900 f882904 00004000 00000000
f8c0018 00000000 c01ae080 f7b5c00 2c018200 00000001 f7b5fc00 00000000
c033420e0 00004000 c01b0584 f7b5fc00 f880c29c f7b5fc00 00000400 00000000
Call Trace: [<c01ae080>] [<c01b0584>] [<c01a3886>] [<c013ab0d>] [<c013ae8d>]
[<c010504d>] [<c0105082>] [<c01055a4>]

Code: 8b 43 18 85 c0 0f 85 48 03 00 00 83 7b 04 00 0f 84 3e 00
<0>Kernel panic: Attempted to kill init!

--- end error thingy

I did the nm on the vmlinux file and while there wasn't
the c01ae528 listed there were:

c01ae4fc  t  flush_commit_list
c01ae888  t  find_newer_jl_for_cn

Although I have no idea what either of those do :-)

Hope you can help.

Tim

