Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUIIRK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUIIRK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUIIRK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:10:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42712 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266273AbUIIRKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:10:55 -0400
Date: Thu, 9 Sep 2004 19:12:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Stearns <wstearns@pobox.com>
Cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-bk15-VP-R9 latency traces
Message-ID: <20040909171207.GA27904@elte.hu>
References: <Pine.LNX.4.58.0409091227020.4188@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409091227020.4188@sparrow>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Stearns <wstearns@pobox.com> wrote:

> Good day, Ingo,
> 	Thanks for all your work on latency.
> 
> 	I just rebooted my Dell Inspiron 8200 into 2.6.9-rc1-bk15-VP-R9
> (using your bk12-R9 patch on top of bk15).  I got three latency traces
> during boot.  I realize you're not as worried about those, but I thought
> I'd report them anyways.

the boot ones can be pretty bad at times and usually they are not a
worry: there's no user functionality during bootup so latencies have no
ill effects - the bootup itself is one huge 30-60 second latency to the
user!

If they happen during regular use too they are a problem. (not including
latencies that happen when suspending/resuming the laptop.)

> 	The above came from an untainted kernel.  Please let me know if
> you need any more details.  Thanks again for your work.

i'd suggest to reset the latency max via this line in
/etc/rc.d/rc.local:

   echo 30 > /proc/sys/kernel/preempt_max_latency

this way you can delimit the boot-time ones from the ones that happen
later during normal use.

	Ingo
