Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310264AbSCLBJE>; Mon, 11 Mar 2002 20:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310279AbSCLBIl>; Mon, 11 Mar 2002 20:08:41 -0500
Received: from zero.tech9.net ([209.61.188.187]:20754 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S310280AbSCLBHZ>;
	Mon, 11 Mar 2002 20:07:25 -0500
Subject: Re: Upgrading Headers?
From: Robert Love <rml@tech9.net>
To: Brian S Queen <bqueen@nas.nasa.gov>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203120100.RAA00468@marcy.nas.nasa.gov>
In-Reply-To: <200203120100.RAA00468@marcy.nas.nasa.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 11 Mar 2002 20:07:05 -0500
Message-Id: <1015895241.928.107.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-11 at 20:00, Brian S Queen wrote:

> When a person switches to, or upgrades a kernel, how do they upgrade the
> associated header files?  The headers in /usr/include won't match the kernel.
> I don't see anything about that in the documentation.
> 
> When I want to program with my new kernel I need to use the new headers, so I 
> have to use #include <linux/fcntl.h> instead of #include <fcntl.h>.  This 
> seems odd.

You don't.  The headers in /usr/include/linux and /usr/include/asm
(which may be a symlink to /usr/src/linux/include/linux and
/usr/src/linux/include/asm, respectively) should point to the kernel
headers that were present when _glibc_ was compiled.

Thus the kernel headers should match your current glibc, not your
current kernel.  This is fine because the kernel will maintain backward
compatibility with the previous interfaces.

If there is something in the new kernel you want/need, recompile your
glibc against those new kernel headers and install accordingly.

	Robert Love


