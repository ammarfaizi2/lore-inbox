Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265963AbUFOU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbUFOU6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUFOU6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:58:42 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:10538 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265963AbUFOU6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:58:38 -0400
Date: Tue, 15 Jun 2004 23:07:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040615210739.GM2310@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk> <20040615044020.GC16664@mars.ravnborg.org> <20040615093807.A1164@flint.arm.linux.org.uk> <20040615085952.GA19197@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615085952.GA19197@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:59:52AM +0100, Christoph Hellwig wrote:
> On Tue, Jun 15, 2004 at 09:38:07AM +0100, Russell King wrote:
> > AFAIAC, if the boot loader does not support the standard Image or
> > zImage format, both of which are the fully documented "official"
> > ARM kernel formats, it is up to the boot loader to provide whatever
> > scripts or programs are needed to manipulate the output of the kernel
> > build to whatever the boot loader wants.
> 
> And we have /sbin/installkernel and ~/bin/installkernel as defined hooks
> for that.

installkernel is a hack to install a kernel for current machine mainly.
Not what I consider a good generic solution.

> In fact I'd love to reduce what the kernel builds to just
> vmlinux and vmlinux.gz, but I guess all those lilo user will kill me ;-)
I do not see the point in this.
Better make life easier - but in a nice and structured way.
Take a look at arch/ppc/boot/simple to see that the bootloader step is not trivial..
The concept with a clean and lean kernel that cannot be used in real-life without
doing lot's of stuff is a dead end.


	Sam
