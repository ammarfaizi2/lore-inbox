Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTBCQuH>; Mon, 3 Feb 2003 11:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBCQuH>; Mon, 3 Feb 2003 11:50:07 -0500
Received: from [217.167.51.129] ([217.167.51.129]:35779 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266809AbTBCQuG>;
	Mon, 3 Feb 2003 11:50:06 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044286828.2397.26.camel@gregs>
References: <1044284924.2402.12.camel@gregs>
	 <1044289102.21009.1.camel@irongate.swansea.linux.org.uk>
	 <1044286828.2397.26.camel@gregs>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044291724.588.68.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 18:02:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 16:40, Grzegorz Jaskiewicz wrote:
> On Mon, 2003-02-03 at 16:18, Alan Cox wrote:
> 
> > Firstly vmalloc isnt permitted in interrupt context (use kmalloc with GFP_KERNEL),
> > although for such small chunks you might want to vmalloc a bigger buffer once
> > at startup.
> i've allso tried kmalloc with the same result.
> Also, in this example it is timer - module isn't cleanly wroted becouse
> it supose to be only an example.

I suppose you meant kmalloc with GFP_ATOMIC...

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
