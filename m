Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVBKIjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVBKIjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVBKIjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:39:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55172 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262223AbVBKIiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:38:08 -0500
Date: Fri, 11 Feb 2005 09:34:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: William Weston <weston@lysdexia.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050211083408.GB3349@elte.hu>
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org> <20050209115121.GA13608@elte.hu> <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org> <20050210075234.GC9436@elte.hu> <420BC23F.6030308@mvista.com> <20050210204031.GA17260@elte.hu> <420BCC9C.8080807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420BCC9C.8080807@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> Possibly from:
> define __raw_spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
> #define __raw_spin_unlock_wait(x) \
> 	do { barrier(); } while(__spin_is_locked(x))
> in asm/spinlock.h
> 
> should that be __raw_spin_is_locked(x) instead?

yeah. Is this in the ARM patch? I havent applied the ARM patch yet,
waiting to see Thomas Gleixner's generic-hardirq based one. (which is
more compelling from an architectural and long-term maintainance POV -
but also more work to address all of RMK's concerns.)

	Ingo
