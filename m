Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274402AbRITKYm>; Thu, 20 Sep 2001 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274403AbRITKYc>; Thu, 20 Sep 2001 06:24:32 -0400
Received: from mail.fbab.net ([212.75.83.8]:28937 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S274402AbRITKYS>;
	Thu, 20 Sep 2001 06:24:18 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org mmokrejs@natur.cuni.cz
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 6.071453 secs)
Message-ID: <05f801c141be$c7d9dca0$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: =?iso-8859-1?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
In-Reply-To: <Pine.OSF.4.21.0109201149110.3983-100000@prfdec.natur.cuni.cz> <05ab01c141bc$6c5a9f60$020a0a0a@totalmef>
Subject: Re: Cannot compile 2.4.10pre12aa1 with 2.95.2 on Debian
Date: Thu, 20 Sep 2001 12:26:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Magnus Naeslund(f)" <mag@fbab.net>
> From: "Martin MOKREJ©" <mmokrejs@natur.cuni.cz>
>
> There are two defines for that FPU thing around line 421 in sched.c, take
> one away (i deleted the 1<<6 one).
>

... And that should have been sched.h, as Martin kindly pointed out ;)
I meant something like this:

--- sched.h~    Thu Sep 20 10:20:44 2001
+++ sched.h     Thu Sep 20 11:29:06 2001
@@ -418,7 +418,9 @@
 #define PF_DUMPCORE    (1UL<<3)        /* dumped core */
 #define PF_SIGNALED    (1UL<<4)        /* killed by a signal */
 #define PF_MEMALLOC    (1UL<<5)        /* Allocating memory */
-#define PF_USEDFPU     (1UL<<6)        /* task used FPU this quantum (SMP)
*/
 #define PF_ATOMICALLOC (1UL<<7)        /* do not block during memalloc */
 #define PF_USEDFPU     (1UL<<8)        /* task used FPU this quantum (SMP)
*/
 #define PF_FREE_PAGES  (1UL<<9)        /* per process page freeing */

Magnus

