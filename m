Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVHFNKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVHFNKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 09:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVHFNKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 09:10:16 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:36325 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261877AbVHFNKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 09:10:13 -0400
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
In-Reply-To: <Pine.LNX.4.61.0508060151330.3728@scrub.home>
References: <1123219747.20398.1.camel@localhost>
	 <20050804223842.2b3abeee.akpm@osdl.org>
	 <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
	 <20050804233634.1406e92a.akpm@osdl.org>
	 <Pine.LNX.4.61.0508051132540.3743@scrub.home>
	 <1123235219.3239.46.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051202520.3728@scrub.home>
	 <1123236831.3239.55.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051225270.3743@scrub.home>
	 <1123238289.3239.57.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051254010.3743@scrub.home>
	 <1123240325.3239.62.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508060151330.3728@scrub.home>
Date: Sat, 06 Aug 2005 16:09:40 +0300
Message-Id: <1123333780.11074.15.camel@haji.ri.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-06 at 02:40 +0200, Roman Zippel wrote:
> I actually looked at the current kcalloc users and besides a few unchecked 
> module parameters, the arguments were either constant or had to be checked 
> anyway. I didn't find a single example which required the "safety" of 
> kcalloc().

Every caller of kcalloc() should do proper bounds checking. It's just
that when they forget to do it, we hopefully avoid a buffer overflow
which can be exploited.

			Pekka

