Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVHVWdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVHVWdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVHVWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:33:22 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:31370 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751434AbVHVWdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:33:19 -0400
Date: Mon, 22 Aug 2005 09:19:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Ondrej Zary <linux@rainbow-software.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: FPU-intensive programs crashing with floating point
Message-ID: <20050822071911.GA18589@elte.hu>
References: <200508210550_MC3-1-A7CF-D29E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508210550_MC3-1-A7CF-D29E@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> (And it looks like there is a small bug in there.  The switch should 
> be:
> 
>         switch (((~cwd) & swd & 0x3f) | (swd & 1 ? swd & 0x240 : 0)) {
> 
> because the SF and CC1 bits are only relevant when IE is set.)

please send a separate patch for that against -mm to Andrew, we want 
this fixed too.

	Ingo
