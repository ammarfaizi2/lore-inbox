Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967761AbWK3A4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967761AbWK3A4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967762AbWK3A4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:56:13 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:4509 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S967761AbWK3A4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:56:12 -0500
Message-ID: <456E2C2C.40303@tlinx.org>
Date: Wed, 29 Nov 2006 16:56:12 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: PM-Timer clock source is slow. Try something else: How slow? What
 other source(s)?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently noticed this message in my bootup that I don't remember
from before:

PCI: Probing PCI hardware (bus 00)
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
------
    How would this affect my clock?  It says to try another
clock source, what type of clock source would it be suggesting I
use? Another chip already in the computer? It is an Intel 440BX
chipset; on an Dell motherboard. Would that be likely to have
another chip source that is compensating?

I don't notice a significant clock slowdown, but I'm running NTP,
so that could be masking the problem.

NTP values appear: to indicated smallish values for clock variance, but I'm
not sure what is "standardly" considered good or bad, so I don't have 
anything
to compare to.

Relevant ntp time vars show:
leap indicator:       00
stratum:              2
precision:            -20
root distance:        0.01445 s
root dispersion:      0.01372 s
jitter:               0.002335 s
stability:            58.565 ppm
broadcastdelay:       0.003998 s
---
  maximum error 130449 us, estimated error 1923 us
ntp_adjtime() returns code 0 (OK)
  offset 1384.000 us, frequency 74.584 ppm, interval 1 s,
  maximum error 130449 us, estimated error 1923 us,
  status 0x1 (PLL),
  time constant 3, precision 1.000 us, tolerance 512 ppm,

--------
    It seems the estimated error is .1923ms, with a precision
of 1us.
    Is the clock "slowness" indicated by the
"offset 1384us, 74.584ppm @ interval 1s?  I.e. do I read that
as the clock is off by 74.584ppm/s, or ~75us/sec, or do I look
at the offset of 1384us/sec, meaning off by .1384ms/s (wouldn't
that be 1384ppm?).  Seems the stability is fairly low, on the
order of 58.656ppm, or about .058ms/s?

    Seems like fewer questions are being answered these days than
in days past.  Is this because of a change in the list focus (maybe
all the patches being submitted),
- or change in list membership, i.e. fewer people up-to-speed on
older HW,
- or increased specialization in specific kernel areas with fewer
having knowledge outside their specific domain, or
what?

    It it is an ugly tradeoff between development time spent
and answering questions that might increase understanding of
people on the list (or maybe it's such common knowledge that
no one bothers to answer...  dunno...

but thanks for any ideas...especially on the original issue.

Linda W.

