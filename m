Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129214AbRBAApO>; Wed, 31 Jan 2001 19:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129203AbRBAApE>; Wed, 31 Jan 2001 19:45:04 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:6203 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129102AbRBAAot>; Wed, 31 Jan 2001 19:44:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Josh Higham" <jhigham@bigsky.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 - failed to exec /sbin/modprobe -s -k binfmt-464c 
In-Reply-To: Your message of "Wed, 31 Jan 2001 14:17:56 PDT."
             <01d801c08bcb$49981720$3ceefcce@adhara.bigsky.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Feb 2001 11:44:41 +1100
Message-ID: <9912.980988281@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 14:17:56 -0700, 
"Josh Higham" <jhigham@bigsky.net> wrote:
>failed to exec /sbin/modprobe -s -k binfmt-464c

You compiled your kernel with support for ELF objects as a module.  You
execute an ELF program, the kernel tries to autoload the ELF module
using modprobe which is an ELF program.  But you need ELF support to
run modprobe, curse and recurse.

Compile the kernel with builtin ELF, not a module.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
