Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264707AbTFASxG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264708AbTFASxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:53:06 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:57835 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264707AbTFASxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:53:05 -0400
Message-Id: <200306011858.h51IwlsG022457@ginger.cmf.nrl.navy.mil>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Thu, 29 May 2003 14:36:37 -0300."
             <20030529173637.GZ24054@conectiva.com.br> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sun, 01 Jun 2003 14:57:02 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030529173637.GZ24054@conectiva.com.br>,Arnaldo Carvalho de Melo writes:
>Sure thing, but hey, spin_lock_irqsave and friends take care of how to behave
>when in up or smp, i.e. its how all the other drivers use spinlocks 8)

but on a single processor machine (i.e. #undef CONFIG_SMP) there is no
chance that there will be reads/writes from other processors so i dont
need any locking OR protection from interrupts.  so the degenerate case
of spin_lock_irqsave() isnt quite as dengerate as i would like for this
particular spin lock.
