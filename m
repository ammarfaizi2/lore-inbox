Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310261AbSCFWFG>; Wed, 6 Mar 2002 17:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310240AbSCFWE4>; Wed, 6 Mar 2002 17:04:56 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:22182 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S310283AbSCFWEm>; Wed, 6 Mar 2002 17:04:42 -0500
Date: Wed, 6 Mar 2002 17:09:51 -0500
To: gyro@zeta-soft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue on dual Athlon MP
Message-ID: <20020306170951.A31564@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a dual Athlon MP box (Tyan S2460 Tiger MP, 1.53 GHz, 2.5 GB Corsair
> PC2100).  The initial installation was of SuSE 7.3, but I have upgraded to
> 2.4.17 with Andrea's 3.5 GB userspace patch.

> Is this a known problem with 2.4.17 and/or the 3.5 GB userspace patch?  I
> have not tried turning off the 3.5 GB config option (`CONFIG_05GB').  I do
> have `CONFIG_MK7' set.

The configuration I would try first on 2.4.19pre1aa1 with 2.5 GB of RAM is 
CONFIG_3GB=y and CONFIG_NOHIGHMEM=y.  If that causes some other problem,
I'd go with CONFIG_2GB, then finally CONFIG_1GB.  Each config changes
the user/kernel memory split.  The loads I've run suggest for best 
performance:

	CONFIG_2GB > CONFIG_1GB > CONFIG_05GB

On my 1GB box, I've been running CONFIG_2GB for a couple months and 
performance is great.  Only lingering question for me is the handling
of oom.  Oom hasn't caused be a problem, but I haven't seen the oom
killer do it's work when I create an oom condition.

BTW, Andrew Morton's read_latency2 patch is a winner.  The read_latency2
diff I use on my 2.4.19pre1aa1 boxes is at:

http://home.earthlink.net/~rwhron/kernel/read_latency2-2.4.19pre1aa1.diff

-- 
Randy Hron

