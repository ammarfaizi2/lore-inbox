Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVGLNji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVGLNji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGLNja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:39:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43429 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261419AbVGLNhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:37:05 -0400
Subject: Re: Kernel header policy
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Staubach <staubach@redhat.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Marc Aurele La France <tsi@ualberta.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <42D3C51D.3020703@redhat.com>
References: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl>
	 <42D3C51D.3020703@redhat.com>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 15:36:34 +0200
Message-Id: <1121175394.3171.28.camel@laptopd505.fenrus.org>
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

On Tue, 2005-07-12 at 09:26 -0400, Peter Staubach wrote:
> Horst von Brand wrote:
> 
> >>I am contacting you to express my concern over a growing trend in kernel
> >>development.  I am specifically referring to changes being made to kernel
> >>headers that break compatibility at the userland level, where __KERNEL__
> >>isn't #define'd.
> >>    
> >>
> >
> >The policy with respect to kernel headers is /very/ simple:
> >
> >  T H E Y   A R E   N E V E R   U S E D   F R O M   U S E R L A N D.
> >
> >This general policy makes all your points (trivially) moot.
> >
> 
> I must admit a little confusion here.  Clearly, kernel header files are
> used at the user level.  The kernel and user level applications must share
> definitions for a great many things.

you are incorrect or rather imprecise here. Userspace needs headers
which define the kernel<->Userspace ABI. That is not the same as "the"
kernel headers.

> 
> Perhaps more precisely, the rule is that kernel header files should not be
> #include'd directly from user level applications, but may be #include'd
> indirectly through other header files as appropriate?

actually the rule in linux is that you should use cleaned up ABI
defining headers. There's several sets to chose from even. Generally
those sets have their origins in the kernel but are stripped down to
just the userspace-abi elements. 
(eg no kernel specific things like spinlocks or inlines or ..)


