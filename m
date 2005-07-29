Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVG2L2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVG2L2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVG2L2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:28:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41690 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262513AbVG2L0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:26:55 -0400
Date: Fri, 29 Jul 2005 13:26:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Message-ID: <20050729112616.GA24965@elte.hu>
References: <200507282308.j6SN8Tg01993@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507282308.j6SN8Tg01993@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> To demonstrate the problem, we turned off these two flags in the cpu 
> sd domain and measured a stunning 2.15% performance gain!  And 
> deleting all the code in the try_to_wake_up() pertain to load 
> balancing gives us another 0.2% gain.

another thing: do you have a HT-capable ia64 CPU, and do you have 
CONFIG_SCHED_SMT turned on? If yes then could you try to turn off 
SD_WAKE_IDLE too, i found it to bring further performance improvements 
in certain workloads.

	Ingo
