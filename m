Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311575AbSCXFjA>; Sun, 24 Mar 2002 00:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311577AbSCXFil>; Sun, 24 Mar 2002 00:38:41 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:54290 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311575AbSCXFid>;
	Sun, 24 Mar 2002 00:38:33 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Boris Bezlaj <boris@kista.gajba.net>
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mdacon.c minor cleanups 
In-Reply-To: Your message of "Sat, 23 Mar 2002 16:42:20 BST."
             <20020323164220.742414d2.boris@kista.gajba.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Mar 2002 16:38:16 +1100
Message-ID: <24384.1016948296@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002 16:42:20 +0100, 
Boris Bezlaj <boris@kista.gajba.net> wrote:
>+#ifdef MODULE
>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("MDA console driver. Default console allocation: vc/13 - vc/16");
>+module_init(mda_console_init);
>+module_exit(mda_console_exit);
> #endif

Do not wrap #ifdef MODULE around those lines.  All the module_* macros
behave correctly when the code is built in, module_init even changes
its behaviour for built in code.

