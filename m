Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263158AbVFXQ6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbVFXQ6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbVFXQ6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:58:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14500 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S263158AbVFXQ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:58:48 -0400
Date: Fri, 24 Jun 2005 09:58:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, yshpilevsky@ru.mvista.com,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
Message-ID: <20050624165841.GD3628@smtp.west.cox.net>
References: <42BAD78E.1020801@ru.mvista.com> <20050623140522.GA25724@logos.cnet> <42BC2501.5090101@ru.mvista.com> <20050624154311.GB3628@smtp.west.cox.net> <42BC34CE.603@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BC34CE.603@ru.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 08:29:02PM +0400, Andrei Konovalov wrote:
> Tom Rini wrote:
[snip]
> >Lets just drop that hunk then..
> 
> Do you mean not to use
>   io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);

So I had myself slightly confused as first, but yes, what Eugene said at
first is right, as shouldn't add more io_block_mappings, we should use
ioremap() and fix drivers.

-- 
Tom Rini
http://gate.crashing.org/~trini/
