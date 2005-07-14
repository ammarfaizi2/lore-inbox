Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVGNKbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVGNKbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVGNKbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:31:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28561 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263004AbVGNKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:31:07 -0400
Subject: Re: Thread_Id
From: Arjan van de Ven <arjan@infradead.org>
To: rvk@prodmail.net
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42D63916.7000007@prodmail.net>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net>
	 <1121327103.3967.14.camel@laptopd505.fenrus.org>
	 <42D63916.7000007@prodmail.net>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 12:30:52 +0200
Message-Id: <1121337052.3967.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 15:36 +0530, RVK wrote:

> >
> >it doesn't return a number it returns a pointer ;) or a floating point
> >number. You don't know :)
> >
> >what it returns is a *cookie*. A cookie that you can only use to pass
> >back to various pthread functions.
> >
> >  
> >
> Hahaha......common. Please clarify following....

I'm missing the joke

> SYNOPSIS
>        #include <pthread.h>
> 
>        pthread_t pthread_self(void);
> 
> DESCRIPTION
>        pthread_self return the thread identifier for the calling thread.

*identifier*.
It doesn't give a meaning beyond that, and if you look at other pthread
manpages (say pthread_join) it just wants that identifier back. If you
want to attach meaning to a thread identifier, please come up with a
manpage/standard that actually defines the meaning of it.

> 
> bits/pthreadtypes.h:150:typedef unsigned long int pthread_t;

and here you 
1) look at implementation details of your specific threading
implementation and 
2) you prove that your analysis is wrong since the implementation you
look at defines it as *unsigned* so it can't be negative. So what your
app does is clearly wrong even within the implementation you look at.


Other implementations are allowed to use different types for this. In
fact, I'd be surprised if NPTL and LinuxThreads would have the same
type... (they'll have the same size for ABI compat reasons of course,
but type... not so sure).



