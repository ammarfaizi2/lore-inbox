Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267880AbTBYJjZ>; Tue, 25 Feb 2003 04:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267883AbTBYJjZ>; Tue, 25 Feb 2003 04:39:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:54411 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267880AbTBYJjY>;
	Tue, 25 Feb 2003 04:39:24 -0500
Date: Tue, 25 Feb 2003 01:49:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: tomlins@cam.org, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] uart_block_til_ready 2.5.63
Message-Id: <20030225014955.3b559ce2.akpm@digeo.com>
In-Reply-To: <20030225093544.B9257@flint.arm.linux.org.uk>
References: <200302242142.26124.tomlins@cam.org>
	<20030225093544.B9257@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 09:49:32.0232 (UTC) FILETIME=[3261C480:01C2DCB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
>
> On Mon, Feb 24, 2003 at 09:42:25PM -0500, Ed Tomlinson wrote:
> > Feb 24 21:14:44 oscar kernel: Code: f6 80 1c 01 00 00 02 75 2d 8b 4d 08 51 e8 10 6e 00 00 85 c0
> 
> Can someone decode this Code: line into something useful please?

You can just feed that single line into ksymooops.  As long
as you have an x86 machine ;)

mnm:/home/akpm> echo "Code: f6 80 1c 01 00 00 02 75 2d 8b 4d 08 51 e8 10 6e 00 00 85 c0" | ksymoops
....

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 80 1c 01 00 00 02      testb  $0x2,0x11c(%eax)
Code;  00000007 Before first symbol
   7:   75 2d                     jne    36 <_EIP+0x36>
Code;  00000009 Before first symbol
   9:   8b 4d 08                  mov    0x8(%ebp),%ecx
Code;  0000000c Before first symbol
   c:   51                        push   %ecx
Code;  0000000d Before first symbol
   d:   e8 10 6e 00 00            call   6e22 <_EIP+0x6e22>
Code;  00000012 Before first symbol
  12:   85 c0                     test   %eax,%eax


1 warning and 1 error issued.  Results may not be reliable.
