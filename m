Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSJCOPj>; Thu, 3 Oct 2002 10:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSJCOPj>; Thu, 3 Oct 2002 10:15:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16458 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261518AbSJCOPi>; Thu, 3 Oct 2002 10:15:38 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210031420.g93EK3L07983@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.40-ac1
To: hch@infradead.org (Christoph Hellwig)
Date: Thu, 3 Oct 2002 10:20:03 -0400 (EDT)
Cc: gerg@snapgear.com (Greg Ungerer), linux-kernel@vger.kernel.org,
       alan@redhat.com (Alan Cox)
In-Reply-To: <20021003151707.A17513@infradead.org> from "Christoph Hellwig" at Oct 03, 2002 03:17:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The sepearate one is horrible maintaince wise.  Please introduce
> CONFIG_MMU and try to make as many _files_ in mm/ conditional on
> those.  Else use the proper ways (cond_syscall(), inline stubs) to
> hide the differences.

The two are so different I think that keeping it seperate is actually the
right idea personally. It will be up to the nommu people to chase the "real
computer" mmu code but I don't think that is a problem.

Some of the other areas you really do want to just hide the differences
nicely - eg in proc

