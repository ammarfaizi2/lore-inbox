Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVEXKDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVEXKDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVEXJpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:45:11 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:25286 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262006AbVEXJUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:20:21 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092013.57A93F9FE@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:20:13 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id B462DFB80

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:51 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261424AbVEXH7w (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 03:59:52 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVEXH7w

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 03:59:52 -0400

Received: from mx1.elte.hu ([157.181.1.137]:54227 "EHLO mx1.elte.hu")

	by vger.kernel.org with ESMTP id S261431AbVEXH7k (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 03:59:40 -0400

Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])

	by mx1.elte.hu (Postfix) with ESMTP id 9302432329E;

	Tue, 24 May 2005 09:58:04 +0200 (CEST)

Received: by chiara.elte.hu (Postfix, from userid 17806)

	id AB1CA1FC2; Tue, 24 May 2005 09:59:37 +0200 (CEST)

Date:	Tue, 24 May 2005 09:59:27 +0200

From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00

Message-ID: <20050524075927.GA20462@elte.hu>

References: <20050509073702.GA13615@elte.hu> <427FBFE1.5020204@mvista.com>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <427FBFE1.5020204@mvista.com>

User-Agent: Mutt/1.4.2.1i

X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73

X-ELTE-VirusStatus: clean

X-ELTE-SpamCheck: no

X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,

	autolearn=not spam, BAYES_00 -4.90

X-ELTE-SpamLevel: 

X-ELTE-SpamScore: -4

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org




* George Anzinger <george@mvista.com> wrote:

> Also, I think that del_timer_sync and friends need to be turned on if 
> soft_irq is preemptable.

you mean the #ifdef CONFIG_SMP should be:

	#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)

?

	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

