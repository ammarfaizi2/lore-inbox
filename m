Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133071AbRDZDOH>; Wed, 25 Apr 2001 23:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133073AbRDZDN6>; Wed, 25 Apr 2001 23:13:58 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:52290 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S133071AbRDZDNp>;
	Wed, 25 Apr 2001 23:13:45 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Martin Clausen <martin@ostenfeld.dk>
cc: netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops when using the Netfilter QUEUE target 
In-Reply-To: Your message of "Tue, 24 Apr 2001 19:25:47 +0200."
             <20010424192547.B2840@ostenfeld.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 Apr 2001 13:13:20 +1000
Message-ID: <13257.988254800@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001 19:25:47 +0200, 
Martin Clausen <martin@ostenfeld.dk> wrote:
>I have encountered a problem (perhaps a bug)! The attached code makes my kernel oops
>in some cases when injecting new packets through Netfilter's QUEUE target. The problem 
>Entering kdb (current=0xc68f6000, pid 884) Oops: Oops                         
>due to oops @ 0xc01e7456                                                      
>eax = 0x000005dc ebx = 0xc7acf224 ecx = 0x0000000e edx = 0xc72f8440           
>esi = 0xc7cee740 edi = 0x00000000 esp = 0xc68f7c90 eip = 0xc01e7456           
>ebp = 0xc68f7cb0 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010287        
>xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc68f7c5c     
>kdb> 
>
>I will be glad to submit som more (debug) information?!

At the very least, you need to run the kdb commands 'bt' (backtrace)
and 'id %eip-0x10' (disassemble around failing instruction).  Registers
and eip on their own are almost meaningless.

ps. Don't copy me on the reply, I only maintain kdb, not the failing
    netfilter code.
