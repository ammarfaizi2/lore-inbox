Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTE2RNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTE2RNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:13:11 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:22953 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262423AbTE2RNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:13:10 -0400
Message-Id: <200305291713.h4THDssG023347@ginger.cmf.nrl.navy.mil>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Thu, 29 May 2003 14:06:22 -0300."
             <20030529170621.GX24054@conectiva.com.br> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 29 May 2003 13:12:13 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030529170621.GX24054@conectiva.com.br>,Arnaldo Carvalho de Melo w
rites:
>no, no, I was talking just about the need for HE_SPIN_LOCK wrapper, not the
>locking, i.e. couldn't it be just:
>
>spin_lock_irqsave(&dev->global_lock, flags)
>
>used so that it is clear that it is a irqsave variation, etc?

i suppose i could change it all back.  at one point, he_spin_lock()
was 'optmized' away on non smp machines (since a single cpu doesnt
tickle the particular h/w problem). 

i didnt want a ton of #ifdef CONFIG_SMP in the driver.
