Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWBMNub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWBMNub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWBMNub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:50:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38541 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751764AbWBMNub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:50:31 -0500
Date: Mon, 13 Feb 2006 14:48:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] hrtimer: cleanup nanosleep
Message-ID: <20060213134844.GB12923@elte.hu>
References: <Pine.LNX.4.61.0602130210350.23831@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602130210350.23831@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> nanosleep is the only user of the expired state, so let it manage this 
> itself, which makes the hrtimer code a bit simpler. The remaining time 
> is also only calculated if requested.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

ok. (causes some churn in Thomas's -hrt queue, but we can then extend 
struct sleep_hrtimer, which is arguably cleaner.)

This is not for v2.6.16 though. (fine to me for -mm, and for 2.6.17)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
