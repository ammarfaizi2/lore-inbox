Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319249AbSIKRor>; Wed, 11 Sep 2002 13:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319250AbSIKRor>; Wed, 11 Sep 2002 13:44:47 -0400
Received: from angband.namesys.com ([212.16.7.85]:25984 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319249AbSIKRoq>; Wed, 11 Sep 2002 13:44:46 -0400
Date: Wed, 11 Sep 2002 21:49:34 +0400
From: Oleg Drokin <green@namesys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911214934.A1488@namesys.com>
References: <20020911193829.A851@namesys.com> <Pine.LNX.4.44.0209111745530.19474-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209111745530.19474-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 05:46:21PM +0200, Ingo Molnar wrote:
> > -	preempt_count()--; \
> > +	if ( --preempt_count()) \
> > +		BUG(); \
> actually, the correct patch is to:
>  -	preempt_count()--; \
>  +	if (!--preempt_count()) \
>  +		BUG(); \
> (note the '!').

Ah, yes. My bad.

Bye,
    Oleg
