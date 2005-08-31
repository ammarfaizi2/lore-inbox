Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVHaS5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVHaS5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 14:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVHaS5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 14:57:51 -0400
Received: from kirby.webscope.com ([204.141.84.57]:42217 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932476AbVHaS5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 14:57:50 -0400
Message-ID: <4315FD1F.9040100@m1k.net>
Date: Wed, 31 Aug 2005 14:55:27 -0400
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Johannes Stezenbach <js@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       linux-dvb-maintainer@linuxtv.org, stable@kernel.org
Subject: Re: [linux-dvb-maintainer] [2.6 patch] add missing select's to DVB_BUDGET_AV
References: <4314B7C2.2080705@m1k.net> <20050831154350.GB8638@stusta.de> <20050831165907.GC21194@linuxtv.org> <20050831170940.GA3766@stusta.de>
In-Reply-To: <20050831170940.GA3766@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Wed, Aug 31, 2005 at 06:59:07PM +0200, Johannes Stezenbach wrote:
>  
>
>>I also added this to linuxtv.org CVS. But I'm not sure it
>>is critical enough to put it in stable.
>>    
>>
>If I were a -stable maintainer, I'd include both patches after they were 
>included in Linus' tree and shipped with one -rc or -mm kernel.
>
>But that's not a strong opinion, it's also OK for me if the patches 
>don't get included in 2.6.13.x .
>  
>
Adrian-

About saa7134-dvb patch, it is already in -mm and the 2.6.13.y stable 
patch queue, but not yet in -git.  Nobody will complain about it when it 
comes time for 2.6.13.1 review, as it was only left out of 2.6.13 by 
accident.  I sent that in, as it is technically part of v4l tree (even 
though it handles DVB code, saa7134-dvb.c is a hybrid v4l file).  This 
is (probably) the reason why JS didn't send an ACK on my patch, but I 
bet Mauro will ACK it when Chris starts the 2.6.13.1-stable review on LKML.

Good looking on the budget_av patch :-) ... I was just about to respond 
to your email before I saw that Johannes already did.  IMHO, I agree 
that your budget_av patch couldn't hurt to go to stable as well, but 
since JS says it isn't critical, I think you might need to lobby to him 
to change his mind.  Personally, I think that both patches should go to 
2.6.13.y -stable, as it IS a behavior correction for Kconfig kernel 
compilation, and without these patches, some users may be left confused 
with supported hardware that won't work (without some googling).  I 
think it is best for user-friendliness to apply these ASAP.

If you choose to send it to stable, feel free to add:

Acked-by: Michael Krufky <mkrufky@linuxtv.org>

...although, since I am not the official maintainer (Johannes is) I 
don't think my ACK matters by much :-(

-MiKE Krufky
