Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUEaQxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUEaQxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 12:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUEaQxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 12:53:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:9415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264689AbUEaQxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 12:53:49 -0400
Date: Mon, 31 May 2004 09:53:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       petero2@telia.com, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: Linux 2.6.7-rc2
In-Reply-To: <1086006023.8188.34.camel@cube>
Message-ID: <Pine.LNX.4.58.0405310948120.4573@ppc970.osdl.org>
References: <1086006023.8188.34.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 May 2004, Albert Cahalan wrote:
> 
> This would be required because of the -Wno-strict-aliasing
> option. For the 2.7.xx kernels, how about we start off by
> replacing -Wno-strict-aliasing with -std=gnu99 ? It's been
> 5 years since 1999. The "restrict" keyword is useful too.

No can do.

Aliasing in gcc is so broken (_purely_ type-based and no way to avoid it
sanely in older versions) that it's not going to happen.

When we can depend on everybody having gcc-3.3+ something, and that one
properly supports the "may_alias" attribute, we may change that.

"restrict" is pretty much useless. It just weakens the already too-weak
alias rules of standard gcc.

		Linus
