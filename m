Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbUAYT0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUAYT0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:26:19 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:61191 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265209AbUAYT0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:26:15 -0500
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle
	disks? (to allow spin-downs)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Lutz Vieweg <lkv@isg.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <40140B0A.90707@isg.de>
References: <40140B0A.90707@isg.de>
Content-Type: text/plain
Message-Id: <1075058769.1756.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 25 Jan 2004 20:26:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-25 at 19:29, Lutz Vieweg wrote:
> Hi everyone,
> 
> I run a server that usually doesn't have to do anything on the local filesystems,
> it just needs to answer some requests and perform some computations in RAM.
> 
> So I use the "hdparm -S 123" parameter setting to keep the (IDE) system disk from
> spinning unneccessarily.
> 
> Alas, since an upgrade to kernel 2.6 and ext3 filesystem, I cannot find a way to
> let the harddisk spin down - I found out that "kjournald" writes a few blocks every
> few seconds.
> 
> As I wouldn't like to downgrade to ext2: Is there any way to keep the 2.6 kjournald
> from writing to idle disks?
> 
> I cannot see a good reason why kjournald would write when there are no dirty buffers -
> but still it does.

Have you tried playing with the laptop-mode patch? It's already in the
-mm kernel tree from Andrew Morton. I've been playing with it a little
(just a few minutes) and seems keep the disks spun down for some time.
However, I haven't been able to get it suit my needs, since I use apps
like Evolution which are continuously writting to the disk.

If you are willing to play with it, I recommend you downloading the
latest -mm patch from http://www.kernel.org, untar the sources and then
read Documentation/laptop-mode.txt.

