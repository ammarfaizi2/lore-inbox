Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVIEO01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVIEO01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVIEO00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:26:26 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:40675 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751276AbVIEO00 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:26:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GMlkaCxKFFv2d9MNNT6Azx7oK4/6gPJ98IsDvsldzgH8ubPr8BurzqESGh/N+Az5uYsC0v/4xT1uKaoanNQ2a5kwTNHw2hegqOifXDZNB3nI7y4z0aFzndAL2I8OiFIniiWVBH9NPy3lOCSSOhtR5gj5av9RyOVbz6eyjjb215A=
Message-ID: <df33fe7c050905072642a9c938@mail.gmail.com>
Date: Mon, 5 Sep 2005 16:26:21 +0200
From: Takis <panagiotis.issaris@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] ipw2200: Missing kmalloc check
Cc: ipw2100-admin@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <431C31A5.3080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125886450.4017.14.camel@nyx> <431C31A5.3080804@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> >       rxq = (struct ipw_rx_queue *)kmalloc(sizeof(*rxq), GFP_KERNEL);
> >+      if (unlikely(!rxq)) {
> >+              IPW_ERROR("memory allocation failed\n");
> >+              return NULL;
> >+      }
> >       memset(rxq, 0, sizeof(*rxq));
> >
> >
> and use kzalloc instead of kmalloc and memset 0?

Yes, but Morton's tree hasn't got the ipw2200 yet, while Linus'
Linux-tree hasn't pulled in the patches containing kzalloc. I'll send
a new patch as soon as the kzalloc patch get in Linus' tree or ipw in
Marton's.

With friendly regards,
Takis
