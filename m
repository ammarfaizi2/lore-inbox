Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbVLOEeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbVLOEeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVLOEeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:34:09 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:25171 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161037AbVLOEeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:34:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S+vG6EW2gVykZfMHtT5bl6BAPyGdgQR+fQJbVif0YKPYPNb3oVrPAcpIACXXqProQskLle5LZ+L5Yw9B6XhFutc8HmB09tv9q4oca9HQD3J76uO62jcN6kCXfjB8rhpE0zuF5ByduRsrDmLxZ4HNxwDXuD2uJNgMNbBfMURRx3E=
From: Kurt Wall <kwallinator@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] slab gcc fix
Date: Wed, 14 Dec 2005 23:35:20 -0500
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0512131327140.23733@schroedinger.engr.sgi.com> <20051213133942.1f742685.akpm@osdl.org>
In-Reply-To: <20051213133942.1f742685.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512142335.20947.kwallinator@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 04:39 pm, Andrew Morton wrote:
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> > Since we no longer support 2.95, we can get rid of this ugly thing.
> >
> >  Signed-off-by: Christoph Lameter <clameter@sgi.com>
> >
> >  Index: linux-2.6.15-rc5-mm2/mm/slab.c
> >  ===================================================================
> >  --- linux-2.6.15-rc5-mm2.orig/mm/slab.c 2005-12-13 13:18:48.000000000
> > -0800 +++ linux-2.6.15-rc5-mm2/mm/slab.c 2005-12-13 13:19:11.000000000
> > -0800 @@ -265,11 +265,10 @@ struct array_cache {
> >    unsigned int batchcount;
> >    unsigned int touched;
> >    spinlock_t lock;
> >  - void *entry[0];  /*
> >  + void *entry[];  /*
>
> There are hundreds of instances of this under include/.  I think we just
> live with it.

Good kernel janitors task, perhaps?

Kurt
-- 
Loud burping while walking around the airport is prohibited in
Halstead, Kansas.
