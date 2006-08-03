Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWHCVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWHCVAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHCVAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:00:33 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:19790 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWHCVAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:00:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OiyhnBq88k4C8NI/6vTSeyAkcfSoqvD60f3y//hchR5nq/ZJAQJK4tCV3ekKgylyCQvg3wmXljZHob4SzgQesUTXcMN9wz6EX0xQdEMbCQ7vxspAaALQya8k642OhWUKi7wHBV4KIT915H8oJXxC5fFNj82113mj1/pKluc/qf4=
Message-ID: <5bdc1c8b0608031400h7e1c03c9o9ae5d17c2519785f@mail.gmail.com>
Date: Thu, 3 Aug 2006 14:00:31 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Hard crash with 2.6.17-rt8
Cc: "Ingo Molnar" <mingo@elte.hu>, "Steven Rostedt" <rostedt@goodmis.org>,
       "hui Bill Huey" <billh@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Two things:

1) While compiling some code this morning on my AMD64 machine using
2.6.17-rt8 I had a hard crash. Everything was hung  - the compile,
Gnome, everything - and I didn't seem to be able to get out with and
key combination so I did a hard reset.

2) I tried rebooting into 2.6.17-rt8 and hung during the boot process.
I managed to catch one not-so-good photo (the flash was on) showing
the "3-level deep critical section nesting". Let me know who to send
it to off list. The end shows something like:

__sched_text_start+0x3b/0x58f...[<00000000>] <=0x0
rt_lock_slowclock_)x30/0x23e...[<00000000>] <=0x0
rt_lock_slowclock_)x30/0x23e...[<00000000>] <=0x0

Up above there is some stuff like:

rt_lock_slowdown
get_page_from_freelist
get_zeroed_page
pte_alloc
__handle_mm_fault.
do_(something I cannot read)
do_(somethign I cannot read)
debug_(something)_mutex_unlock
error_exit

Unfortunately stuff in there is blanked out by the flash reflecting on
the screen. (Stupid me! Sorry!)

   I've gone back to 2.6.17-rt5 for now which has been running great
and never crashed on me.

   I hope this little bit helps confirm some of what you all are
debuggin in your other threads.

Cheers,
Mark
