Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319154AbSIKPfz>; Wed, 11 Sep 2002 11:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318765AbSIKPfz>; Wed, 11 Sep 2002 11:35:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39085 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319154AbSIKPfz>;
	Wed, 11 Sep 2002 11:35:55 -0400
Date: Wed, 11 Sep 2002 17:46:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Drokin <green@namesys.com>
Cc: Jens Axboe <axboe@suse.de>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, <linux-kernel@vger.kernel.org>,
       <andre@linux-ide.org>
Subject: Re: 2.5 Problem Status Report
In-Reply-To: <20020911193829.A851@namesys.com>
Message-ID: <Pine.LNX.4.44.0209111745530.19474-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Sep 2002, Oleg Drokin wrote:

> -	preempt_count()--; \
> +	if ( --preempt_count()) \
> +		BUG(); \

actually, the correct patch is to:

 -	preempt_count()--; \
 +	if (!--preempt_count()) \
 +		BUG(); \

(note the '!').

	Ingo

