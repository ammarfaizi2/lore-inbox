Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVDODZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVDODZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 23:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVDODZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 23:25:28 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:59261 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261730AbVDODZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 23:25:24 -0400
Subject: Re: [PATCH] sched: fix never executed code due to expression
	always false
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Ingo Molnar <mingo@elte.hu>, rml@tech9.net,
       torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DMH3H-0006Jg-00@gondolin.me.apana.org.au>
References: <E1DMH3H-0006Jg-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 13:25:20 +1000
Message-Id: <1113535520.6517.18.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 12:59 +1000, Herbert Xu wrote:
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > -               if (unlikely((long long)now - prev->timestamp < 0))
> > +               if (unlikely(((long long)now - (long long)prev->timestamp) < 0))
> 
> You can write this as
> 
> (long long)(now - prev->timestamp)
> 

True. Combined that with Matt's suggestion, and we probably have
the cleanest solution. Thanks.



