Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266642AbUFRSa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266642AbUFRSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266671AbUFRSa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:30:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:32466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266642AbUFRS1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:27:06 -0400
X-Authenticated: #20450766
Date: Fri, 18 Jun 2004 20:17:41 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7
In-Reply-To: <Pine.LNX.4.56.0406180040050.15935@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.60.0406181937250.7426@poirot.grange>
References: <200406171753.i5HHrx38015816@fire-2.osdl.org>
 <Pine.LNX.4.60.0406172152310.5847@poirot.grange>
 <Pine.LNX.4.56.0406180040050.15935@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Jesper Juhl wrote:

>
>> -			skb = dev_alloc_skb( len + hdrlen + 2 );
>> +			skb = dev_alloc_skb( len + hdrlen + 2 + 2 );
>
> nitpicking, but why not
> 	skb = dev_alloc_skb( len + hdrlen + 4 );
> ?

Well, I just didn't have my pocket calculator at hand at that moment, so, 
I decided to let the compiler compute it for me:-) It's just short for

#define SKB_ALIGN 2
 	skb = dev_alloc_skb( len + hdrlen + 2 + SKB_ALIGN );
 	skb_reserve(skb, SKB_ALIGN);

Guennadi
---
Guennadi Liakhovetski

