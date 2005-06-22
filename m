Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVFVUN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVFVUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVFVUNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:13:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13257 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262011AbVFVUJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:09:03 -0400
Date: Wed, 22 Jun 2005 22:05:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Karim Yaghmour <karim@opersys.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622200554.GA16119@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622192927.GA13817@nietzsche.lynx.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> > target is subject to the HD test. For a pipe, this goes from 9.4us
> > to 21.6. For UDP this goes from 22us to 1070us !!! Even on a
> > system without any load, the numbers are similar. Ouch.
> 
> I'm involved in other things now, but I wouldn't be surprised if it 
> was some kind of scheduler bug + softirq wacked interaction. [...]

the UDP-over-localhost latency was a softirq processing bug that is 
fixed in current PREEMPT_RT patches. (real over-the-network latency was 
never impacted, that's why it wasnt noticed before.)

	Ingo
