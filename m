Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbTICBrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbTICBrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:47:31 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:28335
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264019AbTICBr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:47:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] Nick's scheduler policy v10
Date: Wed, 3 Sep 2003 11:55:03 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <3F5044DC.10305@cyberone.com.au> <127320000.1062514664@[10.10.2.4]> <3F552CBB.1060906@cyberone.com.au>
In-Reply-To: <3F552CBB.1060906@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031155.04056.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003 09:50, Nick Piggin wrote:
> Martin J. Bligh wrote:
> >>>Not convinced of that - mm performs worse than mainline for me.
> >>
> >>Well, one of Con's patches caused a lot of idle time on volanomark.
> >>The reason for the change was unclear. I guess either a fairness or
> >>wakeup latency change (yes, it was a very scientific process, ahem).
> >>
> >>Anyway, in the process of looking at the load balancing, we found
> >>and fixed a problem (although it might now possibly over balance).
> >>This did cure most of the idle problems.
> >>
> >>So it could just be small changes causing things to go out of whack.
> >>I will try to get better data after (if ever) the thing is working
> >>nicely on the desktop.
> >
> >I think Con and I worked out that the degredations I was seeing
> >(on kernbench and SDET) were due to (in his words) "my hacks throwing the
> >cc cpu hogs onto the expired array more frequently".
>
> This didn't explain the huge idle time increases on volanomark and
> SPECjbb I think.

Yeah this was before the profile showed it to be idle time, and before I 
isolated it to Ingo's A3 patch.

Con

