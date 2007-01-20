Return-Path: <linux-kernel-owner+w=401wt.eu-S965286AbXATOrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbXATOrb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 09:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbXATOrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 09:47:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34057 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965281AbXATOra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 09:47:30 -0500
Subject: Re: wake_up() takes long time to return
From: Arjan van de Ven <arjan@infradead.org>
To: kalash nainwal <nirvana.code@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e92e3a770701200224n42c948d5oe75aa5eb907e9786@mail.gmail.com>
References: <e92e3a770701200224n42c948d5oe75aa5eb907e9786@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 20 Jan 2007 15:47:26 +0100
Message-Id: <1169304446.3055.764.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-20 at 15:54 +0530, kalash nainwal wrote:
> Hi there,
> 
> We've a kernel (n/w) module, which sits over ethernet. Whenever a pkt
> is received (in softirq), after doing some minimal processing,
> wake_up() is called to wake up another kernel thread which does rest
> (bulk) of the processing.
> 
> We notice that this wake_up() call is sometimes taking as long as 48
> milli-seconds to return. This happens around 10 times out of 10M. We
> earlier thought its possibly because of the contention on rq->lock,
> but we see the same phenomenon even on a uniprocessor box. So obviosly
> thats not the case.
> 
> We can't figure out any other reason for wake_up() to take this much
> time? As this call comes directly in our (receive) hotpath, we're very
> concerned. Any help would be greatly appreciated.


Hi,

unfortunately you didn't provide your driver code or a link to it, so
people who want to help you would have to guess in the dark... could you
reply to this email with the pointer to the code?

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

