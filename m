Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSGAQzC>; Mon, 1 Jul 2002 12:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSGAQzB>; Mon, 1 Jul 2002 12:55:01 -0400
Received: from smtp.intrex.net ([209.42.192.250]:24080 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S315805AbSGAQzA>;
	Mon, 1 Jul 2002 12:55:00 -0400
Date: Mon, 1 Jul 2002 13:02:49 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
Message-ID: <20020701130249.A2203@tricia.dyndns.org>
References: <200207011612.JAA01302@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207011612.JAA01302@adam.yggdrasil.com>; from adam@yggdrasil.com on Mon, Jul 01, 2002 at 09:12:56AM -0700
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 09:12:56AM -0700, Adam J. Richter wrote:
> 	As an extereme illustration, imagine a module with 4095 bytes
> of non-init data and 2 bytes of init data.  With the .init section loaded,
> the module will occupy two pages.  Freeing the .init section will free
> an entire page, making 4096 bytes available to the system, even though
> only two bytes were in the .init section.

Surly we can do better and just not generate .init sections for modules
where the size would be smaller than a page.  Is binutils capable of doing
this given the proper linker script?

Thanks,

Jim
