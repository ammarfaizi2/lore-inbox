Return-Path: <linux-kernel-owner+w=401wt.eu-S1754587AbWL0RmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbWL0RmU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbWL0RmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:42:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44102 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587AbWL0RmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:42:19 -0500
Date: Wed, 27 Dec 2006 18:39:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] disconnect warp check from hrtimers
Message-ID: <20061227173957.GA18900@elte.hu>
References: <20061227172828.998757000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227172828.998757000@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0756]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> These calls were getting inconsistent wrt. the xtime_lock. The 
> xtime_lock should be held when doing the warp check update, and 
> interrupts should be off.

thanks, applied. Does this solve some warnings that you saw trigger?

	Ingo
