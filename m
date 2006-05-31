Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWEaFuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWEaFuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 01:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWEaFuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 01:50:50 -0400
Received: from ns.suse.de ([195.135.220.2]:12997 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932094AbWEaFus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 01:50:48 -0400
From: Andi Kleen <ak@suse.de>
To: piet@bluelane.com
Subject: Re: linux-2.6 x86_64 kgdb issue
Date: Wed, 31 May 2006 07:50:33 +0200
User-Agent: KMail/1.9.1
Cc: "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <446E0B4B.9070003@ru.mvista.com> <200605251207.27699.amitkale@linsyssoft.com> <1149050728.26542.85.camel@piet2.bluelane.com>
In-Reply-To: <1149050728.26542.85.camel@piet2.bluelane.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605310750.34047.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Perhaps we should add a kgdb config menu option and #define
> CONFIG_16KSTACKS to double the stack size so the kernel can be 
> debugged with more context available. I'm currently using -O0 for 
> the networking stack and -O1 for the rest of the kernel. Sounds like 
> it would be helpful now for AMD64 targets.

You only got stack overflows when working with kgdb right? 
Sounds like a kgdb problem to me then that can and should be probably fixed. e.g. 
afaik kgdb isn't reentrant anyways so it could just use static buffers.

I would suggest against adding any new config options for this - it would
conflict with the great goal of having loadable debuggers that work
on any kernels.

-Andi

