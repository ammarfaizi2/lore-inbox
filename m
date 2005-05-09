Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVEIMNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVEIMNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVEIMNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:13:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10458 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261307AbVEIMNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:13:36 -0400
Date: Mon, 9 May 2005 14:13:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: Real-Time Preemption: Magic Sysrq p doesn't work
Message-ID: <20050509121324.GA20941@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323203@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323203@MAILIT.keba.co.at>
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


* kus Kusche Klaus <kus@keba.com> wrote:

> While testing, I noticed that Sysrq p is silently ignored on current 
> RT kernels with RT preemption: The syslog contains a message that 
> Sysrq p was pressed, but no registers are printed.

yes, that's because the keyboard interrupt is 'threaded' - hence there's 
no 'interrupted stack' to print a backtrace of. You should be able to 
see all (including currently running) task's backtraces in SysRq-T 
output.

are you trying to use it to debug a particular bug?

	Ingo
