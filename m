Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRBBX0I>; Fri, 2 Feb 2001 18:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRBBXZ5>; Fri, 2 Feb 2001 18:25:57 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12037 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129747AbRBBXZp>;
	Fri, 2 Feb 2001 18:25:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jocelyn Mayer <jocelyn.mayer@netgem.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels 
In-Reply-To: Your message of "Sat, 03 Feb 2001 00:04:16 BST."
             <3A7B3CF0.50327D75@netgem.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Feb 2001 10:25:39 +1100
Message-ID: <10847.981156339@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Feb 2001 00:04:16 +0100, 
Jocelyn Mayer <jocelyn.mayer@netgem.com> wrote:
>I had some problems while compiling some applications 
>with the 2.4.0 kernel.
>The problem was a conflict between string.h from the libc
>and the one from the kernel, which is included in fs.h

Rule 1.  Applications must not include include kernel headers directly.

Rule 2. Any glibc that has a symlink from /usr/include/{linux,asm} to
/usr/src/linux/include/{linux,asm} is wrong.

Relying on /usr/include/{linux,asm} always pointing at the current
kernel source is broken as designed.  /usr/include/{linux,asm} must be
real directories that are shipped as part of glibc, not symlinks to
some random version of the kernel.  Fix /usr/include.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
