Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965395AbWAGCN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965395AbWAGCN0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965399AbWAGCN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:13:26 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55449 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965395AbWAGCN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:13:26 -0500
Subject: Re: [PATCH] slab: Adds missing kmalloc() checks.
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060106133051.367f2d9b.lcapitulino@mandriva.com.br>
References: <20060106131246.0b9fde8c.lcapitulino@mandriva.com.br>
	 <1136561087.2940.39.camel@laptopd505.fenrus.org>
	 <20060106133051.367f2d9b.lcapitulino@mandriva.com.br>
Date: Sat, 07 Jan 2006 04:12:50 +0200
Message-Id: <1136599971.7163.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-01-06 at 13:12 -0200, Luiz Fernando Capitulino wrote:
> | >  Adds two missing kmalloc() checks in kmem_cache_init(). Note that if the
> | > allocation fails, there is nothing to do, so we panic();

On Fri, 06 Jan 2006 16:24:47 +0100
Arjan van de Ven <arjan@infradead.org> wrote:
> | ok so what good does this do? if you die this early.. you are in deeper
> | problems, and can't boot. while this makes the code bigger...

On Fri, 2006-01-06 at 13:30 -0200, Luiz Fernando Capitulino wrote:
>  Well, you'll get a panic with a message saying you have no memory to
> boot, instead of a OOPS with a kernel NULL pointer derefecence, which
> will make you look for a bug.

The code is in init section so I don't think size is an issue. A plain
BUG_ON would be better though as it can be disabled by the embedded
folk.

			Pekka

