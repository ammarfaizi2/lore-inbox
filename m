Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131652AbRBDLI7>; Sun, 4 Feb 2001 06:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131648AbRBDLIt>; Sun, 4 Feb 2001 06:08:49 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:36526 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S131652AbRBDLIe>; Sun, 4 Feb 2001 06:08:34 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Mohit Aron" <aron@Zambeel.com>, <linux-kernel@vger.kernel.org>
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
Date: Sun, 4 Feb 2001 03:08:32 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKMEICNHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200102032253.OAA08890@mohit-linux.zambeel.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	The program you attached worked perfectly for me. You need to
'fflush(stdout);' after each 'printf'. You didn't expect perfect alternation
did you? That's totally unrealistic. You cannot use the scheduler as a
synchronization mechanism.

--

Thread1
Thread1
Thread2
Thread1
Thread1
Thread2
Thread1
Thread2
Thread2
Thread2

--

	DS

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mohit Aron
> Sent: Saturday, February 03, 2001 2:53 PM
> To: linux-kernel@vger.kernel.org
> Subject: system call sched_yield() doesn't work on Linux 2.2
>
>
> Hi,
> 	the system call sched_yield() doesn't seem to work on Linux
> 2.2. Does
> anyone know of a kernel patch that fixes this ?
>
> Attached below is a small program that uses pthreads and demonstrates that
> sched_yield() doesn't work. Basically, the program creates two
> threads that
> alternatively try to yield CPU to each other.
>
>
> - Mohit
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
