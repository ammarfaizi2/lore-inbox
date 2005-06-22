Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVFVWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVFVWJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVFVWFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:05:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43916 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262557AbVFVWBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:01:00 -0400
Date: Thu, 23 Jun 2005 00:00:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050622220007.GA28258@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <20050622082450.GA19957@elte.hu> <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org>
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


* William Weston <weston@sysex.net> wrote:

> Hi Ingo,
> 
> Latency traces (attached) are looking a little bit better with -50-11.  
> The CPU consistently seems to idle for ~200us at a time in the traces.  
> Maximum wakeup latency since boot (over an hour ago) is 310us.  With 
> previous RT kernels, maximums would generally go over 800us.

these are all the first type of latencies, which seem to be hardware 
related. Could you try to boot the UP kernel, do you see these latencies 
there too? (if yes then please post those too)

> Should I apply your SMT scheduler latency fix, or is that patch for 
> -mm only?

the fix is in current -RT kernels already. As can be seen from the 
latency traces you got, the SMT scheduler is not causing latencies 
anymore.

	Ingo
