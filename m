Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTABCNt>; Wed, 1 Jan 2003 21:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbTABCNt>; Wed, 1 Jan 2003 21:13:49 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29821 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265368AbTABCNs>; Wed, 1 Jan 2003 21:13:48 -0500
Date: Wed, 1 Jan 2003 21:22:15 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
Subject: Re: sparc32 net devices
Message-ID: <20030101212215.B1006@devserv.devel.redhat.com>
References: <20030101204954.GD17053@louise.pinerecords.com> <20030101155849.A20852@devserv.devel.redhat.com> <20030101215949.GG17053@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030101215949.GG17053@louise.pinerecords.com>; from szepe@pinerecords.com on Wed, Jan 01, 2003 at 10:59:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 1 Jan 2003 22:59:49 +0100
> From: Tomas Szepe <szepe@pinerecords.com>

> Here's a first stab then.  No need to include sbus devices
> in drivers/net/Kconfig, they're all there already.  Unfortunately
> this has to tune a lot of drivers' bus dependencies, I'm quite sure
> I've missed some.

>  config NET_VENDOR_SMC
>  	bool "Western Digital/SMC cards"
> -	depends on NET_ETHERNET
> +	depends on NET_ETHERNET && (ISA || MCA || EISA)
>  	help
>  	  If you have a network (Ethernet) card belonging to this class, say Y

Looks ok with me. If Dave or Jeff take it for common drivers/net/,
I'm taking arch/sparc part. Thanks. I trust you tried at least to
compile the result :)

-- Pete
