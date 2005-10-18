Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVJRFeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVJRFeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 01:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJRFeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 01:34:19 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:41177 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932359AbVJRFeT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 01:34:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=izDjnCO0H3nqRVkBo4jNY1y4/WoE0L79q6BFLlKcH/kKF5hs99cK/icTrc2Q5aNLti6SQ/9W65MibumZvJHvCPNnqaJEcr6wg5buNKQ7oezjQ8OhybOKSK9fmxWEGDC7O+6tLUJssp4eR61c0Omj1kjgCmKzWKT9+6SkrmIbgZg=
Message-ID: <b6fcc0a0510172234l7d1eb7d1mc130708968f76c92@mail.gmail.com>
Date: Tue, 18 Oct 2005 09:34:18 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] fix warning and small bug in cassini driver
Cc: Adrian Sun <asun@darksunrising.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200510172024.53106.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510172024.53106.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>  drivers/net/cassini.c:1930: warning: long unsigned int format, different type arg (arg 4)

>        u64 compwb = le64_to_cpu(cp->init_block->tx_compwb);

> -               printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %lx\n",

> +               printk(", %llx", compwb);

You've added similar warning on alpha, sparc64, ...
