Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTKIP73 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTKIP73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:59:29 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:35820
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262603AbTKIP70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:59:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Davide Libenzi <davidel@xmailserver.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Date: Mon, 10 Nov 2003 02:59:18 +1100
User-Agent: KMail/1.5.3
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.44.0311090747110.12198-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311090747110.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311100259.18883.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003 02:53, Davide Libenzi wrote:
> On Sun, 9 Nov 2003, Martin J. Bligh wrote:
> > I ran it on the 16-way - no difference in performance. If the code is
> > correct as was before (and I agree, it seems it was), perhaps it's just
> > in need of a big fat comment to explain the confusion? ;-)
>
> Ingo already dropped a fat comment ;) This is the relevant part:
>
>  * We fend off statistical fluctuations in runqueue lengths by
>  * saving the runqueue length during the previous load-balancing
>  * operation and using the smaller one the current and saved lengths.

Well that was the comment that led me to make that patch. 

After discussion with mbligh it seems the confusion coming from me seeing
->prev_cpu_load
as the load for that runqueue the last time we balanced; whereas it's actually 
the load of the last runqueue checked during the balancing. 

Anyway the performance differences are tiny on my testing and non existent on 
mblighs so forget it.

Con

