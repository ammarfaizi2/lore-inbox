Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262031AbTCLVGk>; Wed, 12 Mar 2003 16:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbTCLVGk>; Wed, 12 Mar 2003 16:06:40 -0500
Received: from rth.ninka.net ([216.101.162.244]:47303 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262031AbTCLVGi>;
	Wed, 12 Mar 2003 16:06:38 -0500
Subject: Re: named vs 2.5.64-mm5
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: jjs <jjs@tmsusa.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
In-Reply-To: <20030312113126.703de259.akpm@digeo.com>
References: <3E6F7C78.1040302@tmsusa.com>
	 <20030312113126.703de259.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047503813.17931.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Mar 2003 13:16:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 11:31, Andrew Morton wrote:
> The changelog has:
> 
> # --------------------------------------------
> # 03/03/08      jmorris@intercode.com.au        1.1083
> # [NET]: Nuke SO_BSDCOMPAT.
> # --------------------------------------------
> 
> Maybe James can tell us what is going on here.
> 
> We should at least place a cap on the number of times that message
> is printed.

Feel free to send a patch for that.

SO_BSDCOMPAT has had ZERO side effects since 2.0.x, and it's been
thus scheduled to be removed for years.  It was merely a binary
state passed in and out of the kernel to the user and had no effect
on socket behavior at all.

Any application still referencing this ancient thing either expects
some kind of different behavior from setting SO_BSDCOMPAT non-zero,
or really doesn't rely on anything at all.

Since SO_BSDCOMPAT has had zero side effects for 5 or so years, this
means that the safe change is to remove all references to SO_BSDCOMPAT
that exist in any application.

