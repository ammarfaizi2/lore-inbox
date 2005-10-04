Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVJDKNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVJDKNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 06:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVJDKNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 06:13:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14554 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751213AbVJDKNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 06:13:53 -0400
Date: Tue, 4 Oct 2005 12:14:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tsc_c3_compensate undefined since patch-2.6.13-rt13
Message-ID: <20051004101434.GA26882@elte.hu>
References: <20050901072430.GA6213@elte.hu> <1125571335.15768.21.camel@localhost.localdomain> <20051003065032.GA23777@elte.hu> <43424B7C.9020508@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43424B7C.9020508@rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Ingo,
> 
> I'll take this late opportunity to report something that have been 
> looking suspicious since 2.6.13-rt13, inclusive, about this symbol of 
> tsc_c3_compensate being undefined and causing some noise on all kernel 
> builds since then.
> 
> To put things in brief, here follows a small exchange that took place 
> on the linux-audio-user list, regarding this thingie. Apparently for 
> Mark, it was a kernel build showstopper.

thanks for the reminder!

> WARNING: 
> /lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/char/hangcheck-timer.ko 
> needs unknown symbol do_monotonic_clock
> WARNING: 
> /lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/acpi/processor.ko needs 
> unknown symbol tsc_c3_compensate

back then i fixed do_monotonic_clock, but forgot to export 
tsc_c3_compensate. I have fixed this in my tree, and have uploaded the 
2.6.14-rc3-rt3 patch. Does it build without warnings for you now?

	Ingo
