Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRABHbB>; Tue, 2 Jan 2001 02:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRABHaw>; Tue, 2 Jan 2001 02:30:52 -0500
Received: from smtp2.mail.yahoo.com ([128.11.68.32]:21778 "HELO
	smtp2.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129525AbRABHaj>; Tue, 2 Jan 2001 02:30:39 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A517B88.13523C37@yahoo.com>
Date: Tue, 02 Jan 2001 01:56:08 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: kaos@ocs.com.au
CC: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: start___kallsyms missing from i386 vmlinux.lds ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wasn't sure if this was overlooked or left out intentionally.

Paul.

--- linux/arch/i386/vmlinux.lds~	Fri Jul  7 03:47:07 2000
+++ linux/arch/i386/vmlinux.lds	Mon Jan  1 07:55:50 2001
@@ -26,6 +26,10 @@
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___kallsyms = .;	/* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+
   _etext = .;			/* End of text section */
 
   .data : {			/* Data */

--------------78FB7F1E1ED5961B194C9718--



__________________________________________________
Do You Yahoo!?
Talk to your friends online with Yahoo! Messenger.
http://im.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
