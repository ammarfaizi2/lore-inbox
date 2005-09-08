Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVIHViI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVIHViI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVIHViI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:38:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965012AbVIHViH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:38:07 -0400
Date: Thu, 8 Sep 2005 14:37:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
In-Reply-To: <Pine.LNX.4.58.0509081418310.3039@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509081433580.3039@g5.osdl.org>
References: <20050908212236.A19542@flint.arm.linux.org.uk>
 <20050908.132634.88719733.davem@davemloft.net> <Pine.LNX.4.58.0509081333450.3039@g5.osdl.org>
 <20050908.134259.51218842.davem@davemloft.net> <Pine.LNX.4.58.0509081418310.3039@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Sep 2005, Linus Torvalds wrote:
> 
> (You might even remove the #ifdef inside the function by then, since "ch" 
> being a constant zero will make 90% of it go away anyway).

Sadly, the remaining part checks "port->sysrq", which doesn't even exist 
unless CONFIG_SERIAL_CORE_CONSOLE is set, so that doesn't work out.

Oh, well. That simple three-liner should work fine, I was just hoping we 
could do the rest more cleanly..

		Linus
