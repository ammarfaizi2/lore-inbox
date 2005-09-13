Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVIMVyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVIMVyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVIMVyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:54:18 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:40145 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S1751068AbVIMVyQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:54:16 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Q: why _less_ performance on machine with SMP then with UP kernel ?
Date: Tue, 13 Sep 2005 22:54:15 +0100
User-Agent: KMail/1.8.2
References: <dg7fbf$5df$1@news.cistron.nl>
In-Reply-To: <dg7fbf$5df$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509132254.15158.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 22:12, Danny ter Haar wrote:
>
> From yesterday till 10:30am i ran 2.6.13.1 in UP mode.
> As you can see blue (==incoming traffic) is fairly constant.
> This morning i compiled/installed 2.6.14-rc1-smp.
> I let it ran till 12:15 but it's clear that it can't keep up
> with the flow of data. I rebooted to 2.6.14-rc1 (UP) and that
> keeps up with the data just fine.
>
> So what is the difference between UP & SMP ?

Is there any indication in the system log that your userland (news?) software 
was having problems? It may be entirely unrelated to your problem, but you 
should anyway be aware of a nasty unresolved issue with all smp kernels >=  
2.6.12 on smp x86_64 systems:

	http://bugzilla.kernel.org/show_bug.cgi?id=4851

If you have any indication of userland problems, you might try
	echo 0 > /proc/sys/kernel/randomize_va_space
which much reduces (but seemingly does not completely remove) this issue for 
most people.

>
> A very confused
>

One of the major symptoms of this particular bug ;)

Andrew Walrond
