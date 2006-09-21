Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWIUC3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWIUC3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 22:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWIUC3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 22:29:46 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:40421 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751010AbWIUC3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 22:29:45 -0400
Subject: Re: 2.6.19 -mm merge plans (NTP changes)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 19:28:51 -0700
Message-Id: <1158805731.8648.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:
> A wander through the -mm patch queue, along with some commentary on my
> intentions.
> 
> When replying to this email, please rewrite the Subject: to something
> appropriate.  Please also attempt to cc the appropriate developer(s).
>
> ntp-move-all-the-ntp-related-code-to-ntpc.patch
> ntp-move-all-the-ntp-related-code-to-ntpc-fix.patch
> ntp-add-ntp_update_frequency.patch
> ntp-add-ntp_update_frequency-fix.patch
> ntp-add-time_adj-to-tick-length.patch
> ntp-add-time_freq-to-tick-length.patch
> ntp-prescale-time_offset.patch
> ntp-add-time_adjust-to-tick-length.patch
> ntp-remove-time_tolerance.patch
> ntp-convert-time_freq-to-nsec-value.patch
> ntp-convert-to-the-ntp4-reference-model.patch
> ntp-cleanup-defines-and-comments.patch
> kernel-time-ntpc-possible-cleanups.patch
> kill-wall_jiffies.patch
>
>  Will merge.

No objections here, but I wanted to put forth some caution as I've seen
some odd NTP behavior with the full NTP patchset on my laptop (either it
does not converge or it just converges *much* more slowly then without).
Unfortunately I've not been able to collect solid enough data to analyze
the issue (really, each run should go for atleast a full day and always
run on the same network).

However, in trying to narrow it down, the
ntp-add-time_adj-to-tick-length patch is where the behavior seems to
change the most. Again, no solid data, so I could be seeing ghosts, but
I wanted to mention it.

I'll try to put aside some time to run a few longer tests and see if I
can get some clear results.

thanks
-john

