Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTEHPzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTEHPy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:54:59 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:8371 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261670AbTEHPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:54:58 -0400
Date: Thu, 8 May 2003 11:37:46 -0400
From: Ben Collins <bcollins@debian.org>
To: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508153746.GQ679@phunnypharm.org>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net> <20030508151643.GO679@phunnypharm.org> <20030508165118.A12791@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508165118.A12791@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 04:51:18PM +0100, Christoph Hellwig wrote:
> On Thu, May 08, 2003 at 11:16:43AM -0400, Ben Collins wrote:
> > How would the driver differentiate between .compat_ioctl == NULL being a
> > case where it should fail because there is no translation, or a case
> > where it should use the compatible .ioctl? Maybe there should be an
> > extra flag like use_compat_ioctl. So:
> 
> .compat_ioctl == NULL:  fail
> .compat_ioctl == .ioctl: everythings fine, I read the docs

That makes sense aswell.

> > This would also solve the current problem where a module that is
> > compiled with compat ioctl's using register_ioctl32_conversion() is not
> > usable on a kernel compiled without CONFIG_COMPAT, even though it very
> > well should be.
> 
> You mean you want to load the same binary module in differently
> compiled kernels?  That's a flawed idea to start with..

I don't, but I don't see the point in it not working in this case.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
