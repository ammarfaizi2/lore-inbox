Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSHGUl6>; Wed, 7 Aug 2002 16:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSHGUl6>; Wed, 7 Aug 2002 16:41:58 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:40187 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316185AbSHGUl5>; Wed, 7 Aug 2002 16:41:57 -0400
Date: Wed, 7 Aug 2002 16:45:37 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adam Lackorzynski <adam@os.inf.tu-dresden.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Oopses on dual Athlon with 2.4.19-ac4 and 2.4.20-pre1-ac1
Message-ID: <20020807164537.J23670@redhat.com>
References: <20020807162932.GH23816@os.inf.tu-dresden.de> <1028746623.18156.328.camel@irongate.swansea.linux.org.uk> <20020807180503.GI23816@os.inf.tu-dresden.de> <1028748942.18478.330.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028748942.18478.330.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 07, 2002 at 08:35:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 08:35:42PM +0100, Alan Cox wrote:
> Can you reproduce it with ACPI disabled ?

Hmm, my system has ACPI disabled.  It hit the following Oops with 
2.4.19-rc3-ac4 on an A7M-266D, but with the power management code 
compiled in.  Note that it hit during the nightly updatedb task.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

Aug  7 04:02:00 bob kernel: int3: 0000
Aug  7 04:02:00 bob kernel: CPU:    0
Aug  7 04:02:00 bob kernel: EIP:    0010:[ctl_cpu_vars+5/192]    Not tainted
Aug  7 04:02:00 bob kernel: EIP:    0010:[<c02bff85>]    Not tainted
Aug  7 04:02:00 bob kernel: EFLAGS: 00000246
Aug  7 04:02:00 bob kernel: eax: 00000000   ebx: 00000000   ecx: c1e1f080   edx: ddd24a40
Aug  7 04:02:00 bob kernel: esi: bffffa30   edi: 08054a58   ebp: bffff908   esp: ca083f94
Aug  7 04:02:00 bob kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 04:02:00 bob kernel: Process find (pid: 1958, stackpage=ca083000)
Aug  7 04:02:00 bob kernel: Stack: c0146784 ddd24a40 ddd24a40 c1e1dec0 08054a58 00000004 bffffa68 00000008 
Aug  7 04:02:00 bob kernel:        00000001 da986e40 ca082000 c0108aab 08054a5a bffffa30 4213030c bffffa30 
Aug  7 04:02:00 bob kernel:        08054a58 bffff908 000000c4 0000002b 0000002b 000000c4 420da0e3 00000023 
Aug  7 04:02:00 bob kernel: Call Trace:    [sys_lstat64+52/112] [system_call+51/56]
Aug  7 04:02:00 bob kernel: Call Trace:    [<c0146784>] [<c0108aab>]
Aug  7 04:02:00 bob kernel: 
Aug  7 04:02:00 bob kernel: Code: db 27 c0 98 44 36 c0 04 00 00 00 24 01 00 00 00 00 00 00 00 

