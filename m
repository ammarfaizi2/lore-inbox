Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267734AbSLGGKF>; Sat, 7 Dec 2002 01:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbSLGGKF>; Sat, 7 Dec 2002 01:10:05 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:1826 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S267734AbSLGGKD> convert rfc822-to-8bit; Sat, 7 Dec 2002 01:10:03 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: "'Linux Kernel Development List'" <linux-kernel@vger.kernel.org>
Subject: RE: POSSIBLE BUG: Debugging Not Automatically Activated in Slab.c -- RESOLVED
Date: Sat, 7 Dec 2002 00:17:45 -0600
Message-ID: <000001c29db8$5cefd500$6c425aa6@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <Pine.LNX.4.33L2.0212062105520.27850-100000@dragon.pdx.osdl.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the non-flame clarification.

Joseph Wagner

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Randy.Dunlap
Sent: Friday, December 06, 2002 11:08 PM
To: Joseph D. Wagner
Cc: 'Linux Kernel Development List'
Subject: Re: POSSIBLE BUG: Debugging Not Automatically Activated in Slab.c

On Fri, 6 Dec 2002, Joseph D. Wagner wrote:

| Before I submit this as an actually bug, I'd like the input of some people
| who know a little more about the Slab Allocator and Kernel Debugging.
|
| The Slab Allocator includes this line:
|
| #ifdef CONFIG_DEBUG_SLAB
|
| in slab.c (line 89) to activate debugging.
|
| However, I couldn't find anywhere in the code where CONFIG_DEBUG_SLAB is
| linked to CONFIG_DEBUG_KERNEL.  In other words, setting the kernel as a
| debug kernel doesn't automatically set the Slab Allocator to debug too.

CONFIG_DEBUG_SLAB is a separate option, listed under the
Kernel Hacking config menu (Debug memory allocations).

| 1) Am I missing something?
|
| 2) Is this intentional or by design?

Design.

| If this is an actually bug, it can be fixed by inserting the following
code
| in slab.h immediately following the #include statements:
|
| #ifdef CONFIG_DEBUG_KERNEL
| #define CONFIG_DEBUG_SLAB
| #endif

Nope, just enable it.

-- 
~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

