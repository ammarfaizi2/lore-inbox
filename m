Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281184AbRKLXS6>; Mon, 12 Nov 2001 18:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281179AbRKLXSt>; Mon, 12 Nov 2001 18:18:49 -0500
Received: from dsl-64-192-223-253.telocity.com ([64.192.223.253]:8198 "EHLO
	mother.fanclubindustries.com") by vger.kernel.org with ESMTP
	id <S281177AbRKLXSb>; Mon, 12 Nov 2001 18:18:31 -0500
Subject: Re: I'd like a bit of help on tracing my oops
From: Chris Vaill <chris@FanClubIndustries.com>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF047EF.883A1D@nortelnetworks.com>
In-Reply-To: <3BF047EF.883A1D@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 12 Nov 2001 18:17:29 -0500
Message-Id: <1005607056.1226.5.camel@toronja>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-12 at 17:06, Christopher Friesen wrote:
>  
> At this point I'm not entirely certain how to track down the exact line of code
> where it's dying.  If I am reading it right, then the program counter was at
> 90016720, is this correct?  Then disassembling vmlinux in gdb should give me the
> instruction corresponding to that address, at which point I need to correlate
> that to the actual code to figure out what's happening, correct?  Is it expected
> that disassembling vmlinux will give the same code as doing a make <file.s> in
> the linux tree?

What I like to do is to add -g to CFLAGS in Makefile.  Then you can do
an "objdump -S vmlinux" and see the original source interspersed with
the disassembled code.

Chris

