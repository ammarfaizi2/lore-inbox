Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946166AbWJ0HXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946166AbWJ0HXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 03:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946165AbWJ0HXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 03:23:13 -0400
Received: from pat.uio.no ([129.240.10.4]:12225 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1946162AbWJ0HXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 03:23:12 -0400
Date: Fri, 27 Oct 2006 09:23:05 +0200 (CEST)
From: Martin Tostrup Setek <martitse@student.matnat.uio.no>
To: David Rientjes <rientjes@cs.washington.edu>
cc: Martin Tostrup Setek <martitse@student.matnat.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated
 correctly
In-Reply-To: <Pine.LNX.4.64N.0610262238510.30255@attu4.cs.washington.edu>
Message-ID: <Pine.LNX.4.63.0610270919500.9454@honbori.ifi.uio.no>
References: <Pine.LNX.4.63.0610270440500.21448@honbori.ifi.uio.no>
 <Pine.LNX.4.64N.0610262027350.12347@attu2.cs.washington.edu>
 <Pine.LNX.4.63.0610270545000.21448@honbori.ifi.uio.no>
 <Pine.LNX.4.64N.0610262238510.30255@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.201, required 12,
	autolearn=disabled, AWL -0.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, David Rientjes wrote:
> I don't see a cpu_delay, I see a cpu_delay_total.  This is the CPU's
> cumulative delay and is only accessible through the user-space accounting
> program Documentation/accounting/getdelays.c.  It reports the number of
> delay values recorded and the real total, virtual total, and delay total;
> each of these are cumulative.

Yes, I reread the docs more carefully. You are right, and I was wrong.

> In the use case for cpu_count, taking the difference of two successive
> cpu_count readings as reported by getdelays.c would find the number of
> delays experienced in that interval.  This is described in the program's
> documentation so by definition the count must be cumulative.  It is also
> possible to find the average delay but dividing cpu_delay_total by
> cpu_count.
>
> The original code is correct and accumulation is appropriate.

Thanks for setting me straight. I withdraw the patch.

Martin
