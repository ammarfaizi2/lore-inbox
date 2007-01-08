Return-Path: <linux-kernel-owner+w=401wt.eu-S932559AbXAHI4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbXAHI4Y (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbXAHI4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:56:23 -0500
Received: from web55614.mail.re4.yahoo.com ([206.190.58.238]:39602 "HELO
	web55614.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932559AbXAHI4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:56:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=q/kMbqp1lJXymv0vZZj1BPzhnhqw6a2/no8aHLQYOpgBkP1dwTET61c5FCybwXFI7JOBGnwWVEYT1rpPKTYFP9e4QVI6ANluWQdNz/6qfTEzXvhSbS2KCfFmGanQfk0Oo/GqxzTsQTR/owxPps+YJDQugfrE1c5y0GGKFqCLDFc=;
X-YMail-OSG: nWR.yuwVM1n5LBKilg1anfYN9G4KjN.ef5gdW8YRgNwqdlIp2SQZRwBx_M053LtgBQ--
Date: Mon, 8 Jan 2007 00:56:22 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Sumit Narayan <talk2sumit@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1458d9610701080039m50d63d82w59cd917691edcb03@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <21977.67702.qm@web55614.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Sumit Narayan <talk2sumit@gmail.com> wrote:

> Asking for KFREE is as silly as asking for a macro to check if kmalloc
> succeeded for a pointer, else return ENOMEM.
> 
> #define CKMALLOC(p,x) \
>    do {   \
>        p = kmalloc(x, GFP_KERNEL); \
>        if(!p) return -ENOMEM; \
>     } while(0)
> 

There are bugs with this approach. This introduces error path leaks. If you have allocated some
memory earlier, then you got to free them.

-Amit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
