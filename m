Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTICPcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263659AbTICPcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:32:31 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:63682 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263625AbTICPc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:32:29 -0400
Message-ID: <3F5609D8.9060809@softhome.net>
Date: Wed, 03 Sep 2003 17:33:44 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Scaling noise
References: <rx83.88x.5@gated-at.bofh.it> <rxrp.8wt.1@gated-at.bofh.it> <rxB3.gg.1@gated-at.bofh.it> <rxB6.gg.5@gated-at.bofh.it> <rydL.17V.1@gated-at.bofh.it> <rGXO.5g9.7@gated-at.bofh.it>
In-Reply-To: <rGXO.5g9.7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> The question which will continue to be important in the next kernel
> series is: How to best accommodate the future many-CPU machines without
> sacrificing performance on the low-end?  The change is that the 'many'
> in the above may start to double every few years.
> 
> Some candidate answers to this have been discussed before, such as
> cache-coherent clusters.  I just hope this gets worked out before the
> hardware ships.
> 

   RT frame works are running single kernel under some kind of RT OS.

   It should be possible to develop framework to run several Linuces 
under single instance of another OS (or Linux itself). And every 
instance of slave Linux whould be told which resources it is responsible 
for.
   You can /partition/ memory, you can say that given instance of kernel 
should use e.g. only CPUs from Nth to N+Mth.
   But some resources - like IDE controllers, GPUs, NICs - are not that 
easy to share. Actually most of the resources are not trivial to share.

   And I'm not sure what will turns out to be easier: write very 
scaleable kernel or make kernel been able to share efficiently resources 
with others.

P.S. My personal belief - that SMP is never going to become comodity. 
EPIC/VLIW - probably. Not SMP/AMP.

