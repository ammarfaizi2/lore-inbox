Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWAFPZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWAFPZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWAFPZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:25:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751515AbWAFPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:25:03 -0500
Subject: Re: [PATCH] slab: Adds missing kmalloc() checks.
From: Arjan van de Ven <arjan@infradead.org>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: akpm <akpm@osdl.org>, penberg@cs.helsinki.fi,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106131246.0b9fde8c.lcapitulino@mandriva.com.br>
References: <20060106131246.0b9fde8c.lcapitulino@mandriva.com.br>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 16:24:47 +0100
Message-Id: <1136561087.2940.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 13:12 -0200, Luiz Fernando Capitulino wrote:
>  Adds two missing kmalloc() checks in kmem_cache_init(). Note that if the
> allocation fails, there is nothing to do, so we panic();

ok so what good does this do? if you die this early.. you are in deeper
problems, and can't boot. while this makes the code bigger...


