Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTKLLgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 06:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTKLLgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 06:36:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63451 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262033AbTKLLgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 06:36:04 -0500
Date: Wed, 12 Nov 2003 12:36:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide cdrom sg like access / rpcmgr ?
Message-ID: <20031112113604.GG21141@suse.de>
References: <1068494681.808.11.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068494681.808.11.camel@simulacron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10 2003, Andreas Jellinghaus wrote:
> Hi,
> 
> Is there some documentation on how to access an ide cdrom in 2.6.0*
> for converting an app that used ide-scsi and sg devices?
> (I'd like to use rpcmgr11.c to unlock my dvd drive. maybe someone
>  already ported it to kernel 2.6.*?)
> 
> the original source uses:
>   fd = open(..., O_RDWR);
> write, read and   ioctl(fd, SG_NEXT_CMD_LEN, &cmdlen);
> (but the ioctl only on lg drives, mine is a hitachi,
> so that shouldn't be necessary).
> 
> or will I need ide-scsi to do these things?

Post the code and I'll show you how to do it. Generally, you should just
use SG_IO or CDROM_SEND_PACKET for this.

-- 
Jens Axboe

