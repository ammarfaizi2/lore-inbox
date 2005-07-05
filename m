Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVGEDou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVGEDou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 23:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVGEDou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 23:44:50 -0400
Received: from [213.184.187.60] ([213.184.187.60]:25861 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261755AbVGEDop convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 23:44:45 -0400
Message-Id: <200507050343.GAA26158@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "=?windows-1256?Q?'Andr=E9_Tomt'?=" <andre@tomt.net>
Cc: "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Ondrej Zary'" <linux@rainbow-software.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: IOWAIT block layer problem
Date: Tue, 5 Jul 2005 06:43:33 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1256"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <42C9C56D.7040701@tomt.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcWA7y2REa+o3gX6Rtej7hUB94K3UAAHkhDg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

André Tomt wrote: {
>>>>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
>>>>Hdparm -tT gives 38mb/s in 2.4.31
>>>>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
>>>>
>>>>Hdparm -tT gives 28mb/s in 2.6.12
>>>>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT

The "hdparm doesn't get as high scores as in 2.4" is a old discussed to
death "problem" on LKML. So far nobody has been able to show it affects
anything  but that pretty useless quasi-benchmark.

>>>No errors though, only sluggish system.

Really sluggish or just "benchmark-sluggish"?
If the former, try selecting a different IO elevator/sheduler.

> When you compare 2.4.31 with 2.6.12 don't you see this problem on your 
> machine?
> If you have a fast system the slowdown won't show, but your IOWAIT 
> will be higher anyway!

Nothing wrong with 73% iowait
Beware 2.4 didn't export that statistic at all to userspace, so 0% iowait
gets reported from most 2.6-ready reporting tools on 2.4.

}

1. hdparm only gives you an indicator.
2. Really sluggish, as in unresponsive to commands.
3. Tried all IO elevators/shedulers to no avail.
4. In 2.4 IOWAIT is added to sys, as in 8% IOWAIT.

