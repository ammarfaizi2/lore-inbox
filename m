Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTEGMne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTEGMne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:43:34 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:36363 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263150AbTEGMnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:43:33 -0400
Date: Wed, 7 May 2003 13:56:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030507135600.A22642@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030507124113.GA412@elf.ucw.cz>; from pavel@ucw.cz on Wed, May 07, 2003 at 02:41:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 02:41:14PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Only change *needed* in each architecture is moving A() macros into
> > > compat.h, so that generic code can use it. Please apply,
> > 
> > Please don't use A() in new code, we now have compat_ptr() and
> > compat_uptr_t for this.
> 
> Fixed now.

Btw, if you really want to move all the 32bit ioctl compat code to the
drivers a ->ioctl32 file operation might be the better choice..

