Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSGYAFQ>; Wed, 24 Jul 2002 20:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318049AbSGYAFQ>; Wed, 24 Jul 2002 20:05:16 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:4736 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S317994AbSGYAFN>; Wed, 24 Jul 2002 20:05:13 -0400
Date: Wed, 24 Jul 2002 17:08:22 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CMIPCI
Message-ID: <20020725000822.GA855@the-penguin.otak.com>
References: <20020724220223.GA761@the-penguin.otak.com> <ahna16$akn$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahna16$akn$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.5.24 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [torvalds@transmeta.com] wrote:
> In article <20020724220223.GA761@the-penguin.otak.com>,
> Lawrence Walton  <lawrence@the-penguin.otak.com> wrote:
> >Looks like CMIPCI does not compile right now.
> 
> For "'synchronize_irq()' used without args", you only need to add the
> irq number as the argument, and it should work. Please test to verify,
> and send in a patch..
> 
> 		Linus

Here it is my first LK patch.
tested even. :)


--- cmipci.c.orig	2002-07-24 17:01:44.000000000 -0700
+++ cmipci.c	2002-07-24 17:02:43.000000000 -0700
@@ -2479,7 +2479,7 @@
 		/* reset mixer */
 		snd_cmipci_mixer_write(cm, 0, 0);
 
-		synchronize_irq();
+		synchronize_irq(dev->irq);
 
 		free_irq(cm->irq, (void *)cm);
 	}



-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


