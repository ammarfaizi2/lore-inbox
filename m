Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310166AbSCADnT>; Thu, 28 Feb 2002 22:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310340AbSCADla>; Thu, 28 Feb 2002 22:41:30 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:54029 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S310350AbSCADk7>; Thu, 28 Feb 2002 22:40:59 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 28 Feb 2002 19:43:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
 tree
In-Reply-To: <Pine.LNX.4.33L.0203010009510.2801-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0202281942420.939-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Rik van Riel wrote:

> Not at all. The yield() function would just be a define to
> the code which no longer works with the new scheduler, ie:
>
> #define yield()				\
> 	current->policy |= SCHED_YIELD;	\
> 	schedule();

or better :

#define yield() \
	do { \
		current->policy |= SCHED_YIELD; \
		schedule(); \
	} while (0)



- Davide


