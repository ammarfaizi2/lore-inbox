Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSFFWU0>; Thu, 6 Jun 2002 18:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317213AbSFFWUZ>; Thu, 6 Jun 2002 18:20:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40947 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317211AbSFFWUY>; Thu, 6 Jun 2002 18:20:24 -0400
Subject: Re: [PATCH] remove suser()
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020606214840.GA1190@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 15:20:23 -0700
Message-Id: <1023402023.1141.6.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 14:48, Pavel Machek wrote:

> > diff -urN linux-2.5.20/include/linux/compatmac.h linux/include/linux/compatmac.h
> > --- linux-2.5.20/include/linux/compatmac.h	Sun Jun  2 18:44:41 2002
> > +++ linux/include/linux/compatmac.h	Tue Jun  4 13:57:33 2002
> > @@ -102,8 +102,6 @@
> >  
> >  #define my_iounmap(x, b)             (((long)x<0x100000)?0:vfree ((void*)x))
> >  
> > -#define capable(x)                   suser()
> > -
> >  #define tty_flip_buffer_push(tty)    queue_task(&tty->flip.tqueue, &tq_timer)
> 
> This is not right I believe. You want to keep compatibility for older
> kernels.

Someone else said this, too.  I must misunderstand the point of this
file... it is used for compatibility with NEW code in OLD kernels? 
Confusing that we keep it in the NEW kernel, then.  I figured it was
just to keep compatibility in general, or allow OLD code to work in the
new kernels.

If the intention is to use this header with other, older, kernels... and
we really want to keep that in a new kernel... then yes - this bit
should be added back.

	Robert Love

