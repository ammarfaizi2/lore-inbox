Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUEUX54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUEUX54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUEUXyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:54:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:23770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265000AbUEUXir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:38:47 -0400
Date: Fri, 21 May 2004 16:41:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA] Check return status of register calls in i82365
Message-Id: <20040521164111.26e90aa6.akpm@osdl.org>
In-Reply-To: <20040521115529.GA1408@gondor.apana.org.au>
References: <20040521115529.GA1408@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> i82365 calls driver_register and platform_device_register without
> checking their return values.  This patch fixes that.

It does more than that - you've also changed it to run platform_device_register()
prior to isa_probe().  How come?
