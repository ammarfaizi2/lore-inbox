Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTK0LA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTK0LA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:00:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45467 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264476AbTK0LA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:00:28 -0500
Date: Thu, 27 Nov 2003 02:59:21 -0800
From: "David S. Miller" <davem@redhat.com>
To: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
Message-Id: <20031127025921.3fed8dd4.davem@redhat.com>
In-Reply-To: <20031127.173320.19253188.yoshfuji@linux-ipv6.org>
References: <1069920883.2476.1.camel@teapot.felipe-alfaro.com>
	<20031127.173320.19253188.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003 17:33:20 +0900 (JST)
YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:

> -	strcpy(t->parms.name, dev->name);
> +	strlcpy(t->parms.name, dev->name, IFNAMSIZ);
>                                           sizeof(t->parms.name)
> 
> or something like that.

I agree, using sizeof() is the less error prone way of
doing things like this.

Felipe could you please rewrite your patch like this?

Thank you.


