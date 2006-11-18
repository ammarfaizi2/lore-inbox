Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756199AbWKRHEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbWKRHEf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 02:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756200AbWKRHEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 02:04:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37573 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1756199AbWKRHEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 02:04:34 -0500
Date: Sat, 18 Nov 2006 08:03:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Regard MSRs in lapic_suspend()/lapic_resume()
Message-ID: <20061118070310.GD32226@elte.hu>
References: <200611180300.18581.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611180300.18581.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0446]
	0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> Read/Write APIC_LVTPC and APIC_LVTTHMR only, if get_maxlvt() returns 
> certain values. This is done like everywhere else in 
> i386/kernel/apic.c, so I guess its correct. Suspends/Resumes to disk 
> fine and eleminates an smp_error_interrupt() here on a K8.
> 
> Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>

nice one! I'm tempted to suggest this for 2.6.19 merge because it causes 
the kernel to do less (so it has little risk of breaking something that 
is working) ... who knows what happens on certain (older?) APICs when we 
try to write back those bogus values.

  Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
