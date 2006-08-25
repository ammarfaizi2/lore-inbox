Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWHYOxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWHYOxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWHYOxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:53:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:27509 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030244AbWHYOwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:52:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pJ+gAke5SZyFBCltbElPlN16d/7yEh+D2QK7I+U6vgGgGg30jVcjOndY5rmZ6A3oxV8snaf+waE2goPmtFUwCFLFcdjXoOq/HYVmzpK74+O13PPlZL1IzVmcR7wF0lGUqN+lXUmM3Pjx7LPVnGyhLtODzg3X9Z7EM+xWrplC4mI=
Date: Fri, 25 Aug 2006 18:52:37 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060825145237.GD5205@martell.zuzino.mipt.ru>
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <20060825142753.GK10659@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825142753.GK10659@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 03:27:53PM +0100, Christoph Hellwig wrote:
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -4,6 +4,8 @@ #
> >
> >  menu "File systems"
> >
> > +if BLOCK
> > +
> >  config EXT2_FS
> >  	tristate "Second extended fs support"
> >  	help
> > @@ -383,8 +385,11 @@ config MINIX_FS
> >  	  partition (the one containing the directory /) cannot be compiled as
> >  	  a module.
> >
> > +endif
> > +
> >  config ROMFS_FS
> >  	tristate "ROM file system support"
> > +	depends on BLOCK
>
> care to group all block-based filesystem in a group so that a single
> if BLOCK will do it?

Note that fs/Kconfig in -mm is mostly split into individual fs/*/Kconfig
files.

