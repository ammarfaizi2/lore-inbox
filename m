Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbRGBP57>; Mon, 2 Jul 2001 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbRGBP5t>; Mon, 2 Jul 2001 11:57:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:57842 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265319AbRGBP5i>; Mon, 2 Jul 2001 11:57:38 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jes Sorensen <jes@sunsite.dk>, David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Mon, 02 Jul 2001 15:22:56 BST." <3484.994083776@redhat.com> 
Date: Mon, 02 Jul 2001 16:57:36 +0100
Message-ID: <2703.994089456@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> #ifdef OUT_OF_LINE_MMIO
> #define res_readb(res, adr) (res->access_ops->readb(res, adr)
> #else
> #define res_readb(res, adr) readb(adr)
> #endif

I think the second #define should be:

	#define res_readb(res, adr) readb(res->start+adr)

for consistency.

David
