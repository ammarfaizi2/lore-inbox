Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264675AbSJOQNZ>; Tue, 15 Oct 2002 12:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264676AbSJOQNZ>; Tue, 15 Oct 2002 12:13:25 -0400
Received: from [195.223.140.120] ([195.223.140.120]:33648 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264675AbSJOQNY>; Tue, 15 Oct 2002 12:13:24 -0400
Date: Tue, 15 Oct 2002 18:19:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-aa1: unresolved symbol in xfs.o
Message-ID: <20021015161908.GC2546@dualathlon.random>
References: <20021015172558.A3154@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015172558.A3154@pc9391.uni-regensburg.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 05:25:58PM +0200, Christian Guggenberger wrote:
> Hi Andrea,
> 
> I'm trying to compile 2.4.20-pre10aa1 with xfs enabled as module.
> make modules_install ends up in:
> 
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.20-pre10aa1/kernel/fs/xfs/xfs.o
> depmod: 	do_generic_file_write
> 
> what to do?

I logged it so it will be fixed. You can link it into the kernel in the
meantime (select Y instead of M). For some reason bleeding edge gcc from
CVS generates a flood of symbol errors when I run depmod before
rebooting, so I don't easily notice these missing exports anymore (I
should run depmod post reboot to notice them). thanks,

Andrea
