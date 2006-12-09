Return-Path: <linux-kernel-owner+w=401wt.eu-S1759117AbWLIGB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117AbWLIGB3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759121AbWLIGB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:01:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48304 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759117AbWLIGB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:01:28 -0500
Date: Fri, 8 Dec 2006 22:01:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Cesar Eduardo Barros <cesarb@cesarb.net>
Cc: netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 driver for Silan SC92031 (second try)
Message-Id: <20061208220114.b531bee0.akpm@osdl.org>
In-Reply-To: <4579C842.5000809@cesarb.net>
References: <4579C842.5000809@cesarb.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 18:17:06 -0200
Cesar Eduardo Barros <cesarb@cesarb.net> wrote:

> From: Cesar Eduardo Barros <cesarb@cesarb.net>
> 
> This is a driver for the Silan SC92031/Rsltek 8139D NIC chip.
> 
> ...

> +config SC92031
> +	depends on NET_PCI && PCI && EXPERIMENTAL
> +	select CRC32
>
> ...
>
> +	} while(unlikely(cmpxchg(&priv->intr_status,

You'll have the arm maintainer after you with a pointy stick.

cmpxchg is only available on certain architectures.  It would be acceptable
to make this driver depend on X86 (or something).  Better to rewrite this
code so it doesn't use cmpxchg.
