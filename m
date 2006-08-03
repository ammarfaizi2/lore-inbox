Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWHCPIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWHCPIv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWHCPIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:08:51 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:13893 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932544AbWHCPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:08:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HY6ZSPcx3T8arYbYLPr5mRBh9AXfsljL8b+4JN9MEYvyRqADWZtXyqklvOpkaGwGSHeZ6CP6pzdoLbQUovp+0yYhwSKjPkbh40BKuRy6vnCzxa9qAmHCBGhPgaafNR91FLXxEkYtI9jRhAr+npfw73GGMXKNDQU+LO41Jor8GQg=
Message-ID: <e6babb600608030808x632bd5e8y7dcb991fe229467d@mail.gmail.com>
Date: Thu, 3 Aug 2006 08:08:49 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: Problems with 2.6.17-rt8
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Bill Huey" <billh@gnuppy.monkey.org>
In-Reply-To: <1154615261.32264.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Call Trace:
> >        <ffffffff8047655a>{_raw_spin_lock_irqsave+24}
> >        <ffffffff8022b272>{__WARN_ON+100}
> >        <ffffffff802457e4>{debug_rt_mutex_unlock+199}
> >        <ffffffff804757b7>{rt_lock_slowunlock+25}
> >        <ffffffff80476301>{__lock_text_start+9}
>
> hmm, here we are probably having trouble with the percpu slab locks,
> that is somewhat of a hack to get slabs working on a per cpu basis.
>
> >        <ffffffff80271e93>{kmem_cache_alloc+202}
>
> It would also be nice to know exactly where ffffffff80271e93 is.

>From the System.map file:

ffffffff80271df5 t gather_stats
ffffffff80271e98 t get_zonemask
ffffffff80271f1e T __mpol_equal

-- 
Robert Crocombe
rcrocomb@gmail.com
