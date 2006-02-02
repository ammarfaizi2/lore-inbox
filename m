Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWBBLMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWBBLMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWBBLMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:12:45 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:59825 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1750748AbWBBLMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:12:44 -0500
Date: Thu, 2 Feb 2006 12:12:42 +0100 (MET)
From: Niklas Edmundsson <Niklas.Edmundsson@hpc2n.umu.se>
X-X-Sender: nikke@kleopatra.acc.umu.se
To: "shin, jacob" <jacob.shin@amd.com>
cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       Andreas.Burghart@fujitsu-siemens.com, Andi Kleen <ak@suse.de>
Subject: RE: powernow-k8: out of sync on Athlon64 x2 3800+
In-Reply-To: <B3870AD84389624BAF87A3C7B83149930293551F@SAUSEXMB2.amd.com>
Message-ID: <Pine.GSO.4.64.0602021205040.14848@kleopatra.acc.umu.se>
References: <B3870AD84389624BAF87A3C7B83149930293551F@SAUSEXMB2.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006, shin, jacob wrote:

> Hello,
>
> I don't think this is a BIOS issue, but a kernel bug in the i386 
> tree.  I believe this was recently discussed and hopefully fixed by 
> Andi Kleen in the kernel mailing list:
>
> http://lkml.org/lkml/2006/1/9/442

My symptoms are identical, so it's probably that bug. I guess my bug 
report through FSC's official support channel will bounce eventually 
then ;)

> This is a critical bug especially for systems running AMD Dual-Core 
> Processors on i386 kernel configuration w/ powernow-k8.
>
> The reason for "powernow-k8 - out of sync" errors is because the 
> cpufreq driver is not aware [or has the wrong idea] about which CPUs 
> are tied together, because cpu_core_id and phy_proc_id data is 
> wrong.
>
> Now this is fairly harmless as Mark mentioned, but only on single 
> socket Dual Core systems.

It doesn't crash my machine, but it also doesn't seem capable to 
really lower the clock frequency...

> I was wondering if anyone has already tested Andi's patch, if it 
> successfully solves this problem, and if the patch has made it into 
> the git yet.

I can give the patch a try if you feel that would help, albeit I 
prefer not rebooting my workstation ;)

/Nikke
-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  Niklas Edmundsson, Admin @ {acc,hpc2n}.umu.se     |    nikke@hpc2n.umu.se
---------------------------------------------------------------------------
  Want to forget all your troubles? Wear tight shoes.
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
