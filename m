Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbTE1OdC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTE1OdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:33:02 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:14857 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264750AbTE1OdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:33:01 -0400
Date: Wed, 28 May 2003 18:45:34 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030528184534.A15717@jurassic.park.msu.ru>
References: <20030527123152.GA24849@alpha.home.local> <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local> <20030527180403.A2292@jurassic.park.msu.ru> <5.2.1.1.2.20030527211552.00a47190@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.2.1.1.2.20030527211552.00a47190@boo.net>; from jasonp@boo.net on Tue, May 27, 2003 at 09:41:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 09:41:12PM -0400, Jason Papadopoulos wrote:
> Also, I've found that lately I have to attempt to boot from the hard
> drive (dqa0) about three times before the kernel finally gets pulled
> off of disk. SRM reports a bootstrap failure each time, but otherwise
> the system seems to work fine. Has anyone seen this behavior?

Yes, it's known problem. Recent 2.4 kernels shutdown the IDE disks
on halt/poweroff, which is extremely annoying on alpha when you return
to SRM prompt to boot another kernel. You'll have to wait until
the disk spins up again.

> Anything else I can do?

Send me please "lspci -vxxx -s 0:d" outputs for
- old (working) kernel;
- new kernel before and after "hdparm -d1".

Ivan.
