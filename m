Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWDUKZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWDUKZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 06:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWDUKZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 06:25:10 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:3347 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932281AbWDUKZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 06:25:09 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.17-rc2
Date: Fri, 21 Apr 2006 11:21:20 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604211121.20036.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 04:27, Linus Torvalds wrote:
> Instead of the normal one-week release schedule, there was now two weeks
> between 2.6.17-rc1 and -rc2, partly because I was travelling for one of
> those weeks, but partly because it was really quiet for a while. Likely a
> lot of people are concentrating on 2.6.16 and vendor releases.
>
> It picked up a bit in the last few days (it's also possible that the US
> people were all just stressed out over tax season ;), and I cut a
> 2.6.17-rc2. I expect to be back to the weekly schedule now, even if it is
> quiet (which I hope it will be).
>
> Not a lot of hugely interesting stuff, with a large portion of the diff
> being a late MIPS update (tssk tssk), and the huge diff from the
> long over-due removal of the Sangoma wan drivers that have been marked
> BROKEN for a long time. Same goes for the qlogicfc driver (which has been
> supplanted by the qla2xxx driver).
>
> As a result, the diff has just tons of deletions, even if most of the rest
> of the changes aren't all that big. But there are netfilter fixes, some
> more splice work, and just tons of random stuff: usb, scsi, knfsd, fuse,
> infiniband..

Something in here (or -rc1, I didn't test that) broke WINE. x86-64 kernel, 
32bit WINE, works fine on 2.6.16.7. I'll check whether -rc1 had the same 
problem and work backwards, but just in case somebody has an idea..

[alistair] 11:17 [~/.wine/drive_c/Program Files/Warcraft III] wine 
war3.exe -opengl
wine: Unhandled page fault on write access to 0x00495000 at address 0x495000 
(thread 0009), starting debugger...
WineDbg starting on pid 0x8
Unhandled exception: page fault on write access to 0x00495000 in 32-bit code 
(0x00495000).
Register dump:
 CS:0023 SS:002b DS:002b ES:002b FS:006b GS:0063
 EIP:00495000 ESP:7f9eff0c EBP:7f9effe8 EFLAGS:00010246(   - 00      -RIZP1)
 EAX:00000000 EBX:7fcb4710 ECX:00400000 EDX:00000000
 ESI:7ffdf3a0 EDI:00495000
Stack dump:
0x7f9eff0c:  7fc794de 7ffdf3a0 00000000 00000000
0x7f9eff1c:  00000000 ffffffff 7fc35ff8 7fc4caf0
0x7f9eff2c:  7fcb4710 00400000 7fcaf784 7f9effe8
0x7f9eff3c:  16d2f22f 168b9967 00000001 00000000
0x7f9eff4c:  00000000 00000000 00000000 00000000
0x7f9eff5c:  00000000 00000000 00000000 00000000
Backtrace:
=>1 0x00495000 EntryPoint in war3 (0x00495000)
  2 0xf7f763ab wine_switch_to_stack+0x17 in libwine.so.1 (0xf7f763ab)
0x00495000 EntryPoint in war3: pushl    %eax

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
