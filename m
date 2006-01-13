Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161550AbWAMKpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161550AbWAMKpC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161551AbWAMKpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:45:01 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:64184 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161550AbWAMKpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:45:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] sched-cleanup_task_activated.patch
Date: Fri, 13 Jan 2006 21:44:41 +1100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
References: <200601132123.01338.kernel@kolivas.org> <20060113022819.432a1b6d.akpm@osdl.org>
In-Reply-To: <20060113022819.432a1b6d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601132144.41524.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 21:28, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > +enum sleep_type {
> > +	SLEEP_NORMAL,
> > +	SLEEP_NONINTERACTIVE,
> > +	SLEEP_INTERACTIVE,
> > +	SLEEP_INTERRUPTED,
> > +};
>
> If you make these 1, 2, 4 and 8
>
> > +static inline int interactive_sleep(enum sleep_type sleep_type)
> > +{
> > +	return (sleep_type == SLEEP_INTERACTIVE ||
> > +		sleep_type == SLEEP_INTERRUPTED);
> > +}
>
> then this can be
>
> 	return sleep_type & (SLEEP_INTERACTIVE|SLEEP_INTERRUPTED);
>
> which would save, oh, about nothing.

Hah yeah I went for readability over one cycle. Change it if you care; I don't 
mind :).

Cheers,
Con
