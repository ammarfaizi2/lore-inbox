Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWDXOLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWDXOLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDXOLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:11:38 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63941 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750811AbWDXOLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:11:37 -0400
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Al Boldi <a1426z@gawab.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200604241653.49647.a1426z@gawab.com>
References: <200511142327.18510.a1426z@gawab.com>
	 <200604241412.13267.a1426z@gawab.com>
	 <84144f020604240422v3f0cd85fm6f45d263d60803cf@mail.gmail.com>
	 <200604241653.49647.a1426z@gawab.com>
Date: Mon, 24 Apr 2006 17:11:35 +0300
Message-Id: <1145887895.32427.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Al Boldi <a1426z@gawab.com> wrote:
> > > Like so?
> > >         if (nr_threads >= max_threads)
> > >                 if (p->pid != su_pid)
> > >                         goto bad_fork_cleanup_count;
> >
> > It's better to combine the two if statements into one with &&.

On Mon, 2006-04-24 at 16:53 +0300, Al Boldi wrote:
> I thought of combining them too, but was afraid of some compile optimization 
> issues.  Remember, this code-path is executed for each and every fork in the 
> system, thus it's highly performance sensitive.

There shouldn't be any difference. What compiler optimizations are you
referring to? Did you study the generated object code?

				Pekka

