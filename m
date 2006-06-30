Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWF3WtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWF3WtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWF3WtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:49:05 -0400
Received: from [212.33.163.222] ([212.33.163.222]:6411 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751549AbWF3WtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:49:04 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline stall
Date: Sat, 1 Jul 2006 01:49:50 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607010149.50573.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-06-30 am 18:13 +0200, ysgrifennodd Andreas Mohr:
> > Use an independently-formatted "unsigned int" for data instead of a
> > restrictive "u16" to avoid instruction fetch pipeline stalls
> > probably caused by the byte calculations later.

I'm hitting this all the time on 2.6 more so than on 2.4, especially for CPU 
bound procs.

> 1. This is a gcc problem

Maybe, but on 2.6, echo 0 > /proc/sys/kernel/randomize_va_space seems to 
improve the situation most of the time, although not always.

> 2. Not everyone is using an intel x86-32 box which has such problems

Specifically, 3/4/586 don't show this problem, whereas 686+ show the problem 
to varying degrees with slowdown upto 333% on P4.

Can you confirm this?

Thanks!

--
Al

