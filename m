Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbRHBLpX>; Thu, 2 Aug 2001 07:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268899AbRHBLpN>; Thu, 2 Aug 2001 07:45:13 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:22962 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268897AbRHBLpB>; Thu, 2 Aug 2001 07:45:01 -0400
Message-ID: <3B693AAC.369E0D22@veritas.com>
Date: Thu, 02 Aug 2001 17:04:04 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Brent Baccala <baccala@freesoft.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel gdb for intel
In-Reply-To: <3B68FADE.DBABBE85@freesoft.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brent,

You can have a look at http://kgdb.sourceforge.net/
That's where I maintain kgdb for x86.
It's many more features and lot of documentation which is
not there in sparc and ppc kgdbs.

Brent Baccala wrote:
> 
> Hi -
> 
> I've been trying to track down a problem I've had with a USB CD-Burner
> locking up.  In the course of my investigations I ported the i386 remote
> gdb stuff to the Linux kernel, because I'm used to using gdb on the
> kernel (it works on SPARC and PPC) instead of trying to read oopses.
> 
> For those not familiar with the remote debug feature, you use two
> computers, connected together with a null modem serial line.  One
> computer has a complete Linux kernel tree on it, compiled with debugging
> information (-g); the other computer is the one running the kernel under
> test.  You can breakpoint and halt the kernel, which puts it in a tight
> little loop reading packets (gdb, not IP) from the serial port and
> responding to the debugger.  You get almost all the features you're used
> to with gdb - stack backtraces, single stepping, source-based variable
> names, intelligent structure decodes, etc.
> 
> Anyway, I'm attaching the patch (against 2.4.6).  After installing, a
> menu option appears under "Kernel hacking" for remote debugging.
> Recompile the whole kernel (make clean) so that it compiles with
> debugging info.  Then supply the "kgdb" switch to the kernel command
> line, make sure the debugging computer is attached on COM1 (or whatever
> you want to call it), and run "target remote /dev/whatever" on the
> debugging computer.  See arch/i386/kernel/stub-i386.c for more info.
> 


-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
