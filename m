Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753896AbWKFWtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbWKFWtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbWKFWtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:49:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753896AbWKFWti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:49:38 -0500
Date: Mon, 6 Nov 2006 14:49:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, acme@mandriva.com
Subject: Re: + net-uninline-xfrm_selector_match.patch added to -mm tree
Message-Id: <20061106144932.8c63a6ed.akpm@osdl.org>
In-Reply-To: <20061106.143831.88477819.davem@davemloft.net>
References: <200611031934.kA3JYCjF030732@shell0.pdx.osdl.net>
	<20061106.143831.88477819.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006 14:38:31 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: akpm@osdl.org
> Date: Fri, 03 Nov 2006 11:34:12 -0800
> 
> > Subject: net: uninline xfrm_selector_match()
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Six callsites, huge.
> > 
> > Cc: Arnaldo Carvalho de Melo <acme@mandriva.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> You can't implement it like this :-)
> 
> xfrm_user.c is a bad place to put the uninlined version because
> this can be built modular, whereas the callsites in places such
> as xfrm_policy.c will be built statically into the kernel.

I would have found that out when I got around to compiling it ;)

Where should the out-of-line function be placed, or should I just drop it? 

