Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUF1V7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUF1V7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUF1V7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:59:55 -0400
Received: from havoc.gtf.org ([216.162.42.101]:20130 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265234AbUF1V7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:59:53 -0400
Date: Mon, 28 Jun 2004 17:59:48 -0400
From: David Eger <eger@havoc.gtf.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7-mm3] cirrusfb: minor fixes
Message-ID: <20040628215948.GA12415@havoc.gtf.org>
References: <20040626233105.0c1375b2.akpm@osdl.org> <20040628212727.A23504@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628212727.A23504@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 09:27:27PM +0200, Francois Romieu wrote:
> Testers welcome.
> 
> - fix unbalanced invocation of pci_enable_device();
> - leaks plugged in cirrusfb_zorro_setup();
> - move framebuffer_release() into cirrusfb_{pci/zorro}_unmap() to balance
>   cirrusfb_{pci/zorro}_setup();
> - make cirrusfb_{pci/zorro}_setup() return adequate error codes when
>   something fails;
> - cirrusfb_zorro_unmap: iounmap() now take as argument values previously
>   returned by ioremap().
> 
> Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

Your patch looks great.  

Not only does it look great, with it X and cirrusfb now play nice with
each other!  Andrew, please apply.  Feel free to add my:

Signed-off-by: David Eger <eger@havoc.gtf.org>

On another note...
pci_request_regions() replaces request_mem_region()... 
looks like virtually all of the FB drivers have suffered from bit
rot.  I guess that's what you get when people just look at code in
drivers/video/ to copy..

-dte
