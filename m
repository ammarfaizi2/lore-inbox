Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTDVWDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDVWDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:03:23 -0400
Received: from rth.ninka.net ([216.101.162.244]:6547 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263885AbTDVWDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:03:23 -0400
Subject: Re: updates for the new IRQ API
From: "David S. Miller" <davem@redhat.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0304211340300.12110-100000@serv>
References: <20030421042934.3728740d.akpm@digeo.com>
	 <Pine.LNX.4.44.0304211340300.12110-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051049709.10911.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 15:15:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 04:49, Roman Zippel wrote:
> #define alloc_irq(irq, handler, flags, name, id) \
> 	request_irq(irq, (irqreturn_t (*)(int, void *, struct pt_regs *))handler, flags, name, id)

Casting 'handler' is not acceptable, see Linus's comments he added
at the top of interrupt.h

-- 
David S. Miller <davem@redhat.com>
