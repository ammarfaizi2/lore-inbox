Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbQLUWgN>; Thu, 21 Dec 2000 17:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbQLUWgD>; Thu, 21 Dec 2000 17:36:03 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:46607 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130225AbQLUWfp>;
	Thu, 21 Dec 2000 17:35:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ian Stirling <root@mauve.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Laptop system clock slow after suspend to disk. (2.4.0-test9/hinote VP) 
In-Reply-To: Your message of "Thu, 21 Dec 2000 02:26:12 -0000."
             <200012210226.CAA20107@mauve.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Dec 2000 09:05:12 +1100
Message-ID: <9602.977436312@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000 02:26:12 +0000 (GMT), 
Ian Stirling <root@mauve.demon.co.uk> wrote:
>I've not noticed this on earlier kernel versions, is there something
>silly I'm missing that's making my DEC hinote VP (p100 laptop)s 
>system clock slow by a factor of five or so after resume?
>Not the CPU or cmos clock, only the system clock.

Try this.

Index: 0-test13-pre3.2/arch/i386/kernel/apm.c
--- 0-test13-pre3.2/arch/i386/kernel/apm.c Mon, 11 Dec 2000 09:23:40 +1100 kaos (linux-2.4/z/c/34_apm.c 1.1.1.7.2.5 644)
+++ 0-test13-pre3.2(w)/arch/i386/kernel/apm.c Fri, 22 Dec 2000 09:04:28 +1100 kaos (linux-2.4/z/c/34_apm.c 1.1.1.7.2.5 644)
@@ -262,6 +262,7 @@ extern int (*console_blank_hook)(int);
  * David Chen <chen@ctpa04.mit.edu>
  */
 #undef INIT_TIMER_AFTER_SUSPEND
+#define INIT_TIMER_AFTER_SUSPEND
 
 #ifdef INIT_TIMER_AFTER_SUSPEND
 #include <linux/timex.h>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
