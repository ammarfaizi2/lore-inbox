Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVGENEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVGENEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVGENCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:02:03 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:973 "EHLO postfix4-1.free.fr")
	by vger.kernel.org with ESMTP id S261839AbVGENAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:00:16 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Avoid to use kmalloc in usb/core/message.c
Date: Tue, 5 Jul 2005 15:00:03 +0200
User-Agent: KMail/1.8.1
Cc: Masatake YAMATO <jet@gyve.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20050705.191221.92572119.jet@gyve.org> <200507051236.37288.duncan.sands@math.u-psud.fr> <1120562571.3180.36.camel@laptopd505.fenrus.org>
In-Reply-To: <1120562571.3180.36.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051500.03748.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I wonder why the invocations of kmalloc are needed in these functions.
> > 
> > Because some architectures can't do DMA to/from the stack.
> 
> doing dma to/from kmalloc also isn't too nice... should be using
> dma_alloc_*() API I guess

The USB core applies dma_map_single to the buffer, so its OK.

Ciao,

Duncan.
