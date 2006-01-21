Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWAUVru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWAUVru (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWAUVru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:47:50 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:56275 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932392AbWAUVru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:47:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BjFgKmAC90PHTQp87cOn+SDzjtBuJPQQ2jzTYze2mOPJZzqS5cV4LFetippvRpEPOEePvtCM5/sQPisvR5e2PJgCdm9Qv2QO/ETidLcO2oMxX9QP0tBBzQL7DBh8Zw5XB1mP7vCmf91fUW8OhQkeImzJZkLZy14jdt8bc5KscKk=
Date: Sun, 22 Jan 2006 01:05:14 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Shaun Savage <savages@tvlinux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: CBD Compressed Block Device, New embedded block device
Message-ID: <20060121220514.GA15433@mipter.zuzino.mipt.ru>
References: <43D3467C.7010803@tvlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D3467C.7010803@tvlinux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 12:46:52AM -0800, Shaun Savage wrote:
> Here is a patch for 2.6.14.5 of CBD
> CBD is a compressed block device that is designed to shrink the file
> system size to 1/3 the original size.  CBD is a block device on a file
> system so, it also allows for in-field upgrade of file system.  If
> necessary is also allows for secure booting, with a GRUB patch.
> +/*
> + *   IOCTL stuff, maybe new file

/dev/null ?

> +    	switch (cmd) {
> +        case HDIO_GETGEO:
> +                {
> +                        struct hd_geometry loc;
> +                        loc.heads = 4;
> +                        loc.sectors = 32;
> +                        loc.cylinders = cbd->nr_sections;
> +                        loc.start = 0;
> +                        return _COPYOUT(loc);
> +                }

Already in generic code.

