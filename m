Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263127AbRE1TS4>; Mon, 28 May 2001 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbRE1TSq>; Mon, 28 May 2001 15:18:46 -0400
Received: from femail9.sdc1.sfba.home.com ([24.0.95.89]:11956 "EHLO
	femail9.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S263126AbRE1TSf>; Mon, 28 May 2001 15:18:35 -0400
From: "Arthur Naseef" <artn@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.2: tq_scheduler functions scheduling and waiting
Date: Mon, 28 May 2001 15:19:17 -0400
Message-ID: <BGEHKJAIFDCFCMFALMGPIEHACAAA.artn@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All:

I have been diagnosing kernel panics for over a week and I have
concerns with the use of tq_scheduler for which I was hoping I
could get some assistance.

Is it considered acceptable for functions in the tq_scheduler
task list to call schedule?  Is it acceptable for such functions
to wait on wait queues?  What limitations exist?

As near as I can determine, the TTY driver code makes use of
the tq_scheduler list for such purposes.

In my testing, I am running with 96 TTY devices (talking to a
high-density modem card) and I consistently achieve kernel panics
when the system is under heavy swapping.  I am continuing to
diagnose the problem.  The kernel panics are triggered mostly in
goodness() and del_from_runqueue(), as indicated by ksym_oops and
gdb, and I suspect the run queue is getting corrupted.

In spite of this testing, I believe that I have an argument against
tq_scheduler functions waiting on wait queues, but I have not
thoroughly convinced myself that (a) this was not already known,
and (b) this is already happening in existing kernel code.

Any help is greatly appreciated.

-art

Arthur Naseef

P.S. If this information is availed through existing documentation,
     searches, or other widely available resources, I would greatly
     appreciate references to this material.  All of my searches to
     date have yielded few results and nothing definitive.

