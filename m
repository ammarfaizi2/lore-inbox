Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVJXTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVJXTFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVJXTFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:05:51 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:408 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751075AbVJXTFu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:05:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YtVwo3VfCLpLDmVjWjlKdwOwg0gxOayCQyO4ykKdjtqZCc18rgIeJTgDOn/3t7oDWpy16TdxdE0K4EP6Aw51QczVKLcRl36HaI/W/c1qd/13VBKEcF64ig1ZBD3wux/UfHEnj2XXrbMeRU7UhA8U/QdZb1JdcJFE5C0+hgEgz+8=
Message-ID: <40f323d00510241205p25eaeaafx3086ff6780e29877@mail.gmail.com>
Date: Mon, 24 Oct 2005 21:05:43 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Lexington Luthor <lexington.luthor@gmail.com>
Subject: Re: 2.6.14-rc5-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <435D1F04.8070502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <435D1F04.8070502@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/05, Lexington Luthor <lexington.luthor@gmail.com> wrote:
> Hi,
>
> This release has a number of build errors for me. I used the vanilla
> 2.6.14-rc5 + 2.6.14-rc5-mm1 patch + CK's 1GB lowmem patch.

you should revert those two patches:
+x86-inline-spin_unlock-if-not-config_debug_spinlock-and-not-config_preempt.patch
+x86-inline-spin_unlock_irq-if-not-config_debug_spinlock-and-not-config_preempt.patch

>
> Here is the make output and the .config listing:
> $ make
> [snip]
> net/ipv4/route.c: In function `rt_check_expire':
> net/ipv4/route.c:663: warning: dereferencing `void *' pointer
> net/ipv4/route.c:663: error: request for member `raw_lock' in something
> not a structure or union
> make[2]: *** [net/ipv4/route.o] Error 1
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2

regards,

Benoit
