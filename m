Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292169AbSBYU2Y>; Mon, 25 Feb 2002 15:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292217AbSBYU2P>; Mon, 25 Feb 2002 15:28:15 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63505 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292169AbSBYU2G>;
	Mon, 25 Feb 2002 15:28:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Patch missing from 2.4.18
In-Reply-To: Your message of "Mon, 25 Feb 2002 11:45:05 -0800."
             <200202251945.g1PJj5S22562@hera.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Feb 2002 07:27:54 +1100
Message-ID: <10488.1014668874@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.18 is missing a patch to fs/binfmt_elf.c.

diff 2.4.18-rc4 to 2.4.18.

Index: 18-rc4.1/fs/binfmt_elf.c
--- 18-rc4.1/fs/binfmt_elf.c Sat, 23 Feb 2002 18:30:39 +1100 kaos (linux-2.4/n/b/2_binfmt_elf 1.1.1.1.1.12.1.3 644)
+++ 18.1/fs/binfmt_elf.c Tue, 26 Feb 2002 07:15:53 +1100 kaos (linux-2.4/n/b/2_binfmt_elf 1.1.1.1.1.12.1.3 644)
@@ -564,9 +564,6 @@ static int load_elf_binary(struct linux_
                        // printk(KERN_WARNING "ELF: Ambiguous type, using ELF\n");
                        interpreter_type = INTERPRETER_ELF;
                }
-       } else {
-               /* Executables without an interpreter also need a personality  */
-               SET_PERSONALITY(elf_ex, ibcs2_interpreter);
        }
 
        /* OK, we are done with that, now set up the arg stuff,


