Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265541AbUFCPhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265541AbUFCPhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFCPhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:37:54 -0400
Received: from [213.146.154.40] ([213.146.154.40]:56466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265542AbUFCPhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:37:36 -0400
Date: Thu, 3 Jun 2004 16:37:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Export swapper_space
Message-ID: <20040603153727.GA17798@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040603161909.D8244@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603161909.D8244@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 04:19:10PM +0100, Russell King wrote:
> swapper_space appears to be needed by modules:
> 
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "swapper_space" [drivers/block/loop.ko] undefined!
> *** Warning: "swapper_space" [drivers/scsi/st.ko] undefined!
> *** Warning: "swapper_space" [drivers/scsi/sg.ko] undefined!

Please not.  This seems to be some cache-flushing magic on the stranger
architectures again :)  Can you check how they're using it in the end
and hopefully fix it by uninlining something?

