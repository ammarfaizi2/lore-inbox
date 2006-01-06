Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWAFPbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWAFPbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWAFPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:31:22 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:50608 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751303AbWAFPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:31:21 -0500
Date: Fri, 6 Jan 2006 13:30:51 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: Adds missing kmalloc() checks.
Message-Id: <20060106133051.367f2d9b.lcapitulino@mandriva.com.br>
In-Reply-To: <1136561087.2940.39.camel@laptopd505.fenrus.org>
References: <20060106131246.0b9fde8c.lcapitulino@mandriva.com.br>
	<1136561087.2940.39.camel@laptopd505.fenrus.org>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2006 16:24:47 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

| On Fri, 2006-01-06 at 13:12 -0200, Luiz Fernando Capitulino wrote:
| >  Adds two missing kmalloc() checks in kmem_cache_init(). Note that if the
| > allocation fails, there is nothing to do, so we panic();
| 
| ok so what good does this do? if you die this early.. you are in deeper
| problems, and can't boot. while this makes the code bigger...

 Well, you'll get a panic with a message saying you have no memory to
boot, instead of a OOPS with a kernel NULL pointer derefecence, which
will make you look for a bug.

-- 
Luiz Fernando N. Capitulino
