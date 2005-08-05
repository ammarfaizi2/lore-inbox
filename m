Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVHEKSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVHEKSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVHEKSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:18:22 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:26542 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262974AbVHEKPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:15:40 -0400
References: <1123219747.20398.1.camel@localhost>
            <20050804223842.2b3abeee.akpm@osdl.org>
            <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
            <20050804233634.1406e92a.akpm@osdl.org>
            <Pine.LNX.4.61.0508051132540.3743@scrub.home>
            <1123235219.3239.46.camel@laptopd505.fenrus.org>
            <Pine.LNX.4.61.0508051202520.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508051202520.3728@scrub.home>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: kernel: use kcalloc instead kmalloc/memset
Date: Fri, 05 Aug 2005 13:15:38 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F33C4A.00004CF4@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Arjan van de Ven wrote:
> > kcalloc does have value, in that it's a nice api to avoid multiplication
> > overflows. Just for "1" it's indeed not the most useful API. 

Roman Zippel writes:
> This would imply a similiar kmalloc() would be useful as well.
> Second, how relevant is it for the kernel? Is that really the best place 
> to check for rogue user parameters?

Please note that the first version of kcalloc() carried over from ALSA took 
only one size parameter but we decided to make it similar to standard 
calloc(). It is useful as an array allocator which is why I think we should 
keep both and simply get rid of the kcalloc(1,...) form. 

                Pekka 

