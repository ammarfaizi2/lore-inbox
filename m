Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291074AbSCSSwz>; Tue, 19 Mar 2002 13:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290796AbSCSSwi>; Tue, 19 Mar 2002 13:52:38 -0500
Received: from web20505.mail.yahoo.com ([216.136.226.140]:38921 "HELO
	web20505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290797AbSCSSwK>; Tue, 19 Mar 2002 13:52:10 -0500
Message-ID: <20020319185209.2308.qmail@web20505.mail.yahoo.com>
Date: Tue, 19 Mar 2002 19:52:09 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux 2.4.19pre3-ac2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I cannot compile shm.c unless I apply this
patch. I hope it's correct, I put 0 in the acct
field just because there was 0 at the
do_mmap() line.

I'm really sorry this patch will be mangled
by my mail client here, but it's a one liner,
self-explanatory.

Regards,
Willy

--- linux/ipc/shm.c-orig        Tue Mar 19 19:45:52
2002
+++ linux/ipc/shm.c     Tue Mar 19 19:46:17 2002
@@ -679,7 +679,7 @@
                shmdnext = shmd->vm_next;
                if (shmd->vm_ops == &shm_vm_ops
                    && shmd->vm_start -
(shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
-                       do_munmap(mm, shmd->vm_start,
shmd->vm_end - shmd->vm_start);
+                       do_munmap(mm, shmd->vm_start,
shmd->vm_end - shmd->vm_start, 0);
                        retval = 0;
                }
        }


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
