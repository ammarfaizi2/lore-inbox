Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTIPBDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 21:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbTIPBDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 21:03:14 -0400
Received: from dp.samba.org ([66.70.73.150]:12476 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261712AbTIPBDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 21:03:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm2 
In-reply-to: Your message of "Mon, 15 Sep 2003 11:34:51 -0300."
             <1063636490.5588.10.camel@lorien> 
Date: Tue, 16 Sep 2003 02:03:45 +1000
Message-Id: <20030916010312.D80562C686@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1063636490.5588.10.camel@lorien> you write:
> net/ipv4/ip_input.c: In function `ip_local_deliver_finish':
.... 
> #ifdef CONFIG_NETFILTER_DEBUG
>         nf_debug_ip_local_deliver(skb);
>         skb->nf_debug =3D3D 0;
> #endif /*CONFIG_NETFILTER_DEBUG*/

Don't know how that happened: screwage in a mailer somewhere I guess.

Fix is simple: should be "skb->nf_debug = 0;"

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
