Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbQKLFzm>; Sun, 12 Nov 2000 00:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbQKLFzd>; Sun, 12 Nov 2000 00:55:33 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:3347 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130149AbQKLFz1>;
	Sun, 12 Nov 2000 00:55:27 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Where is it written? 
In-Reply-To: Your message of "Sat, 11 Nov 2000 23:36:42 MDT."
             <14862.11370.341594.433057@wire.cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Nov 2000 16:55:20 +1100
Message-ID: <7577.974008520@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000 23:36:42 -0600 (CST), 
Peter Samuelson <peter@cadcamlab.org> wrote:
>You mean trivial changes to understand the ELF magic number for a
>riscoid-ABI x86 object.  (You wouldn't lie to the linker and call them
>SysV objects, now, would you?)  Also gdb and libbfd need to know about
>stack frames.  Admittedly none of this is strictly necessary just to
>link and boot a kernel.

Any ABI change needs to be externalised for modules.  Otherwise symbol
versions will not detect that the kernel was compiled with -mregparm=3
but the module was compiled with parameters on stack.  Good thing this
is 2.5 material.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
