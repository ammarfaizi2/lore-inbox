Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289132AbSAGIZi>; Mon, 7 Jan 2002 03:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSAGIZ3>; Mon, 7 Jan 2002 03:25:29 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11027 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289132AbSAGIZS>; Mon, 7 Jan 2002 03:25:18 -0500
Message-ID: <3C395A2C.B7A24844@zip.com.au>
Date: Mon, 07 Jan 2002 00:19:56 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <20020104163635.A1268@mea-ext.zmailer.org>,
		<20020104163635.A1268@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Fri, Jan 04, 2002 at 04:36:35PM +0200 <20020107100022.A1914@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> 
>   I have partial evidence that EXT3 may be part of the problem,
>   as another machine with RAID-1 disks with EXT2 filesystems
>   is not hanging up when running RedHat 2.4.16-0.9custom kernel.
>   That another machine has, however, IDE disks.

I'd be surprised if an ext3 bug could cause a freeze as solid
as this one.  ext3's write submission patterns are somewhat different
from other filesystems, and we've exposed a few problem in underlying
layers in the past because of this.  But who knows...

Have you enabled the NMI watchdog?  nmi_watchdog=1 on the LILO
commandline?

Also, I'd be inclined to enable all the kernel debug options,
including SLAB debug.

-
