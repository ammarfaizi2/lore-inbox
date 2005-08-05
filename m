Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVHEJ7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVHEJ7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVHEJ7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:59:39 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:43180 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262945AbVHEJ7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:59:38 -0400
References: <1123219747.20398.1.camel@localhost>
            <20050804223842.2b3abeee.akpm@osdl.org>
            <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
            <20050804233634.1406e92a.akpm@osdl.org>
            <Pine.LNX.4.61.0508051132540.3743@scrub.home>
            <1123235219.3239.46.camel@laptopd505.fenrus.org>
In-Reply-To: <1123235219.3239.46.camel@laptopd505.fenrus.org>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: kernel: use kcalloc instead kmalloc/memset
Date: Fri, 05 Aug 2005 12:59:37 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F33889.00006F1C@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 11:37 +0200, Roman Zippel wrote:
> > BTW we already have 420 "kcalloc(1, ...)" user and 41 without the 1 
> > argument, most of them are in sound, which introduced it in first place.
> > Can we please deprecate that function before it spreads any further?

Arjan van de Ven writes:
> kcalloc does have value, in that it's a nice api to avoid multiplication
> overflows. Just for "1" it's indeed not the most useful API. 

Indeed, kcalloc should not be deprecated as it is meant for array 
allocation. I can send patches that replace kcalloc(1,...) with kzalloc if 
there are no other janitors interested... 

                 Pekka 

