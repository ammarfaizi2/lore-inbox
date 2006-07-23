Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWGWT5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWGWT5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 15:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWGWT5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 15:57:04 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:17896 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751285AbWGWT5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 15:57:03 -0400
Message-ID: <1153684596.44c3d474639cc@portal.student.luth.se>
Date: Sun, 23 Jul 2006 21:56:36 +0200
From: ricknu-0@student.ltu.se
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153445087.44c02cdf40511@portal.student.luth.se> <44C02F35.4000604@garzik.org>
In-Reply-To: <44C02F35.4000604@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Jeff Garzik <jeff@garzik.org>:

> ricknu-0@student.ltu.se wrot> 

> > diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> > index b3a2cad..498813b 100644
> > --- a/include/linux/stddef.h
> > +++ b/include/linux/stddef.h
> > @@ -10,6 +10,9 @@ #else
> >  #define NULL ((void *)0)
> >  #endif
> >  
> > +#define false	((0))
> > +#define true	((1))
> 
> I would say:
> 
> #undef true
> #undef false

Sorry about the delay but why the undef's? Found no problem to remove those and
think a warning would be good if a #define of false/true would show up
(otherwise, why have them there in the first place?).

> enum {
> 	false	= 0,
> 	true	= 1
> };
> 
> #define false false
> #define true true

/Richard Knutsson

