Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUFOI74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUFOI74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 04:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUFOI74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 04:59:56 -0400
Received: from [213.146.154.40] ([213.146.154.40]:58855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265373AbUFOI7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 04:59:55 -0400
Date: Tue, 15 Jun 2004 09:59:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040615085952.GA19197@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk> <20040615044020.GC16664@mars.ravnborg.org> <20040615093807.A1164@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615093807.A1164@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:38:07AM +0100, Russell King wrote:
> AFAIAC, if the boot loader does not support the standard Image or
> zImage format, both of which are the fully documented "official"
> ARM kernel formats, it is up to the boot loader to provide whatever
> scripts or programs are needed to manipulate the output of the kernel
> build to whatever the boot loader wants.

And we have /sbin/installkernel and ~/bin/installkernel as defined hooks
for that.  No need to support everything and a kitchensink in the kernel
build process.  In fact I'd love to reduce what the kernel builds to just
vmlinux and vmlinux.gz, but I guess all those lilo user will kill me ;-)
