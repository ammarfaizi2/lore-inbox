Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAKMqn>; Thu, 11 Jan 2001 07:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRAKMqd>; Thu, 11 Jan 2001 07:46:33 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:49418 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129610AbRAKMqW>;
	Thu, 11 Jan 2001 07:46:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: List Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Thu, 11 Jan 2001 12:32:10 -0000."
             <12129.979216330@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 23:46:14 +1100
Message-ID: <17071.979217174@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001 12:32:10 +0000, 
David Woodhouse <dwmw2@infradead.org> wrote:
>I'm not suggesting that we change it drastically, only that we add 
>the option of static (compile-time) registration for those entries which 
>require it. 

So you want two services, one static for code that does not do any
initialisation and one dynamic for code that does do initialisation.
Can you imagine the fun when somebody adds startup code to a routine
that was using static registration?  Oh dear, I added init code so I
have to remember to change from static to dynamic registration, and
that affects the link order so now I have to tweak the Makefile.
Thanks, but no thanks!

Stick to one method that works for all routines, dynamic registration.
If that imposes the occasional need for a couple of extra calls in some
routines and for people to think about initialisation order right from
the start then so be it, it is a small price to pay for long term
stability and ease of maintenance.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
