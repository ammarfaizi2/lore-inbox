Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTKATBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 14:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTKATBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 14:01:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13060 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263415AbTKATBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 14:01:22 -0500
Date: Sat, 1 Nov 2003 20:01:14 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031101190114.GA936@alpha.home.local>
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local> <20031101182518.GL4640@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101182518.GL4640@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 08:25:18PM +0200, Ville Herva wrote:
 
> Is there anything special in booting to DOS instead of different linux
> kernel, other than that it would rule out some strange kernel bug that is
> present in 2.2 and 2.4?

No, it was just to quicky confirm or deny the fact that it's the kernel
which causes the problem. It could have been a long standing bug in the IDE
or partition code, and which is present in several kernels. But as you say
that it affects two different controllers, there's little chance that it's
caused by anything except linux itself. Then, the reboot on DOS will only
tell you if the drives were corrupted at startup or at shutdown.

> Yes, but I find it unlikely. The partition table in within the first 512
> bytes and the corruption was in bytes 1060-1080. Also, one of the corrupted
> disks is on i815 and another in on HPT370.

I agree, but I proposed it just because it was simple to test.

> BTW: the corruption happens on warm reboots (running reboot command), not
> just on power off / on.

OK, but the BIOS scans your disks even during warm reboots. Though I don't
think it comes from there because of your two different controllers.

Willy

