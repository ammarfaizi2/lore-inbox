Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTDRQwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbTDRQwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:52:02 -0400
Received: from verein.lst.de ([212.34.181.86]:22541 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263152AbTDRQwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:52:01 -0400
Date: Fri, 18 Apr 2003 19:03:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs (2/7) - minor miscdev changes
Message-ID: <20030418190355.A718@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
References: <20030418181250.B363@lst.de> <52znmn7os3.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <52znmn7os3.fsf@topspin.com>; from roland@topspin.com on Fri, Apr 18, 2003 at 09:29:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 09:29:00AM -0700, Roland Dreier wrote:
>  int misc_register(struct miscdevice * misc)
>  {
> -	static devfs_handle_t devfs_handle, dir;
>  	struct miscdevice *c;
> +	char buf[256];
> 
>     Wouldn't it be better not to have a 256-byte buffer on the stack?

You're probably right.  But 64 bytes should be enough anyway - that's
what devfs uses everywhere else.

