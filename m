Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264295AbUEDU5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUEDU5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264349AbUEDU5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:57:07 -0400
Received: from havoc.gtf.org ([216.162.42.101]:14538 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264295AbUEDU5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:57:01 -0400
Date: Tue, 4 May 2004 16:56:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, davem@redhat.com
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Message-ID: <20040504205659.GA17583@havoc.gtf.org>
References: <20040503230911.GE7068@logos.cnet> <20040504204633.GB8643@fs.tum.de> <200405042253.11133@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405042253.11133@WOLK>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 10:53:11PM +0200, Marc-Christian Petersen wrote:
> On Tuesday 04 May 2004 22:46, Adrian Bunk wrote:
> 
> Hi Adrian,
> 
> > drivers/net/net.o(.text+0x60293): In function `tg3_get_strings':
> > : undefined reference to `WARN_ON'
> > make: *** [vmlinux] Error 1
> > There's no WARN_ON in 2.4.
> 
> yep. Either we backport WARN_ON ;) or simply do the attached.

I would rather add the simple patch to 2.4.x core, since tg3 isn't the
only driver that continues to be heavily used in 2.4, and thus will
continue to be actively maintained for a while...

	Jeff



