Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVBJUku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVBJUku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVBJUku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:40:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21635 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261883AbVBJUkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:40:39 -0500
Date: Thu, 10 Feb 2005 21:40:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: William Weston <weston@lysdexia.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050210204031.GA17260@elte.hu>
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org> <20050209115121.GA13608@elte.hu> <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org> <20050210075234.GC9436@elte.hu> <420BC23F.6030308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420BC23F.6030308@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> If I want to write a patch that will work with or without the RT patch 
> applied is the following enough?
> 
> #ifndef RAW_SPIN_LOCK_UNLOCKED
> typedef raw_spinlock_t spinlock_t
> #define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
> #endif

yeah. (but you should rather use DEFINE_SPINLOCK/DEFINE_RAW_SPINLOCK)

	Ingo
