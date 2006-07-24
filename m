Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWGXHVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWGXHVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 03:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWGXHVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 03:21:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:18846 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751434AbWGXHVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 03:21:24 -0400
Date: Mon, 24 Jul 2006 09:15:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Make touch_nmi_watchdog imply touch_softlockup_watchdog on all archs
Message-ID: <20060724071546.GA29478@elte.hu>
References: <44B61D0A.7010305@stud.feec.vutbr.cz> <p73ejwpmy6m.fsf@verdi.suse.de> <44B683EB.20709@stud.feec.vutbr.cz> <200607131936.34832.ak@suse.de> <44C3F2CB.5090204@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C3F2CB.5090204@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> touch_nmi_watchdog() calls touch_softlockup_watchdog() on both 
> architectures that implement it (i386 and x86_64). On other 
> architectures it does nothing at all. touch_nmi_watchdog() should 
> imply touch_softlockup_watchdog() on all architectures. Suggested by 
> Andi Kleen.
> 
> Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

Acked-by: Ingo Molnar <mingo@elte.hu>

although i suspect this could be cleaned up by consolidating both under 
touch_watchdog(), right?

	Ingo
