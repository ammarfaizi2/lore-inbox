Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVGNM0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVGNM0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVGNM0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:26:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261218AbVGNMZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:25:58 -0400
Subject: Re: Thread_Id
From: Arjan van de Ven <arjan@infradead.org>
To: rvk@prodmail.net
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42D64A85.7020305@prodmail.net>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net>
	 <1121327103.3967.14.camel@laptopd505.fenrus.org>
	 <42D63916.7000007@prodmail.net>
	 <1121337052.3967.25.camel@laptopd505.fenrus.org>
	 <42D64A85.7020305@prodmail.net>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 14:25:43 +0200
Message-Id: <1121343943.3967.32.camel@laptopd505.fenrus.org>
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


> >
> So then what is the meaning of that typedef and why its still there ?

the typedef means that the *IMPLEMENTATION* uses an unsigned long to
store its cookie in.

> 
> >Other implementations are allowed to use different types for this. In
> >fact, I'd be surprised if NPTL and LinuxThreads would have the same
> >type... (they'll have the same size for ABI compat reasons of course,
> >but type... not so sure).
> >
> >  
> >
> I haven't faced the same returns with 2.4.18. So why is it so with 2.6.x 
> kernels ? pthread_self() on 2.4.18 was returning the same as gettid() 
> with 2.6.x.

pure luck. NPTL threading uses it to store a pointer to per thread info
structure; other threading (linuxthreads) may have stored a pid there to
identify the internal thread. nptl is 2.6 only so you might have
switched implementation of threading when you switched kernels.



