Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTFPVoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFPVoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:44:24 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:12299 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264363AbTFPVoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:44:23 -0400
Subject: Re: Can't unmount NFS - System freezes
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030616224504.0132cc1b.florian.huber@mnet-online.de>
References: <20030616224504.0132cc1b.florian.huber@mnet-online.de>
Content-Type: text/plain
Message-Id: <1055800694.586.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jun 2003 23:58:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 22:45, Florian Huber wrote:

> if I try to unmount a NFS-mounted directory my system freezes.
> There is neither a error message nor a log entry.
> 
> I can't type anymore, but the NUM-Lock LED can still be switched
> on/off. The host is also not ping-able.
> 
> I also tried different mount options (nfsvers=3, nfsvers=2, default or
> even my former 2.4.x settings).
> 
> The NFS server is a 2.4.20 machine exporting with rw,async.
> The client is using 2.5.71 (same with 2.5.70-mm9).
> 
> I'm sorry that I can't give you a more detailed description of the
> problem. Perhaps you can give me some hints how to debug this.

Can you try to reproduce this from the console? I've seen this behavior
on previous versions of the kernel, and also the related kernel panic on
the console. It would be interesting if you could gather the OOPS
message and attach it in a message.

I would also suggest trying the following patch if you can:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.71/2.5.71-mm1/broken-out/rpc-depopulate-fix.patch

Or else, the latest 2.5.71-bk snapshot to see if it's fixed. At least,
I've been unable to reproduce previous NFS crashes on 2.5.71-mm1.

