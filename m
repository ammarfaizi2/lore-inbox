Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTEHPiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEHPit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:38:49 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:20742 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261789AbTEHPis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:38:48 -0400
Date: Thu, 8 May 2003 16:51:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ben Collins <bcollins@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508165118.A12791@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Collins <bcollins@debian.org>,
	"David S. Miller" <davem@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net> <20030508151643.GO679@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030508151643.GO679@phunnypharm.org>; from bcollins@debian.org on Thu, May 08, 2003 at 11:16:43AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 11:16:43AM -0400, Ben Collins wrote:
> How would the driver differentiate between .compat_ioctl == NULL being a
> case where it should fail because there is no translation, or a case
> where it should use the compatible .ioctl? Maybe there should be an
> extra flag like use_compat_ioctl. So:

.compat_ioctl == NULL:  fail
.compat_ioctl == .ioctl: everythings fine, I read the docs

> This would also solve the current problem where a module that is
> compiled with compat ioctl's using register_ioctl32_conversion() is not
> usable on a kernel compiled without CONFIG_COMPAT, even though it very
> well should be.

You mean you want to load the same binary module in differently
compiled kernels?  That's a flawed idea to start with..

