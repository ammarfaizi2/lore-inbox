Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTIHNgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbTIHNgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:36:13 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:22545 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262321AbTIHNfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:35:44 -0400
Date: Mon, 8 Sep 2003 15:35:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Schwab <schwab@suse.de>,
       <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Message-ID: <20030908133542.GA15564@win.tue.nl>
References: <Pine.LNX.4.44.0309071617380.21192-100000@home.osdl.org> <200309081503.20459.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309081503.20459.arnd@arndb.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 03:03:20PM +0200, Arnd Bergmann wrote:

> +#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
> +#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
> +#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
> +#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
> +#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
> +#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))

Yes, good.
Then I have another trivial request: change the identifier used for the third parameter.
Since it is called "size" people think that it is a size.
The new checking will hit them, but still, it would be good to use
the correct identifiers. What about "argtype"?

Andries

