Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWDPSoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWDPSoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 14:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDPSod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 14:44:33 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:25521 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750792AbWDPSod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 14:44:33 -0400
Date: Sun, 16 Apr 2006 20:44:26 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Al Boldi <a1426z@gawab.com>, ck list <ck@vds.kolivas.org>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [patch][rfc] quell interactive feeding frenzy
Message-ID: <20060416184426.GA15642@rhlx01.fht-esslingen.de>
References: <200604112100.28725.kernel@kolivas.org> <200604151705.18786.kernel@kolivas.org> <200604152345.39850.a1426z@gawab.com> <200604160923.00047.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604160923.00047.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 16, 2006 at 09:22:59AM +1000, Con Kolivas wrote:
> The current value, 6ms at 1000HZ, is chosen because it's the largest value 
> that can schedule a task in less than normal human perceptible range when two 
> competing heavily cpu bound tasks are the same priority. At 250HZ it works 
> out to 7.5ms and 10ms at 100HZ. Ironically in my experimenting I found the 
> cpu cache improvements become much less significant above 7ms so I'm very 
> happy with this compromise.

Heh, this part is *EXACTLY* a fully sufficient explanation of what I was
wondering about myself just these days ;)
(I'm experimenting with different timeslice values on my P3/450 to verify
what performance impact exactly it has)
However with a measly 256kB cache it probably doesn't matter too much,
I think.

But I think it's still important to mention that your perception might be
twisted by your P4 limitation (no testing with slower and really slow
machines).

Andreas
