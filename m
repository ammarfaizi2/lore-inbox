Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbTFAUpC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbTFAUpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:45:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36067
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264725AbTFAUpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:45:01 -0400
Subject: Re: [PATCH][ATM] assorted he driver cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, davem@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306011858.h51IwlsG022457@ginger.cmf.nrl.navy.mil>
References: <200306011858.h51IwlsG022457@ginger.cmf.nrl.navy.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054497613.5863.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 21:00:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-01 at 19:57, chas williams wrote:
> In message <20030529173637.GZ24054@conectiva.com.br>,Arnaldo Carvalho de Melo writes:
> >Sure thing, but hey, spin_lock_irqsave and friends take care of how to behave
> >when in up or smp, i.e. its how all the other drivers use spinlocks 8)
> 
> but on a single processor machine (i.e. #undef CONFIG_SMP) there is no
> chance that there will be reads/writes from other processors so i dont
> need any locking OR protection from interrupts.  so the degenerate case
> of spin_lock_irqsave() isnt quite as dengerate as i would like for this
> particular spin lock.

Then why are you using spin_lock_irqsave ?

