Return-Path: <linux-kernel-owner+w=401wt.eu-S1751911AbXAVHv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbXAVHv1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 02:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXAVHv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 02:51:27 -0500
Received: from server077.de-nserver.de ([62.27.12.245]:43181 "EHLO
	server077.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXAVHv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 02:51:26 -0500
Message-ID: <45B46CEE.4090808@profihost.com>
Date: Mon, 22 Jan 2007 08:51:10 +0100
From: Stefan Priebe - FH <studium@profihost.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS or Kernel Problem / Bug
References: <20060801142755.C2326184@wobbly.melbourne.sgi.com> <44CED8F4.9080208@profihost.com> <20060801143212.D2326184@wobbly.melbourne.sgi.com> <44CEDA1D.5060607@profihost.com> <20060801143803.E2326184@wobbly.melbourne.sgi.com> <44CF36FB.6070606@profihost.com> <20060802090915.C2344877@wobbly.melbourne.sgi.com> <44D07AB7.3020409@profihost.com> <20060802201805.A2360409@wobbly.melbourne.sgi.com> <45B35CD7.4080801@profihost.com> <20070122061852.GT33919298@melbourne.sgi.com>
In-Reply-To: <20070122061852.GT33919298@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 84.134.23.182
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm  not shure but perhaps it isn't an XFS Bug.

Here is what i find out:

We've about 300 servers at the momentan and 5 of them are "old" Intel 
Pentium 4 Machines with a DFI PM-12 Mainboard with VIA chipset. It only 
happens on THESE Machines. Other P4 Machines with a Tyan Mainboard or a 
Gigabyte Mainboard are not affected. All 300 machines runs the same 
Debian 3.0 with self build kernel. Some of these 5 use a 3ware 
controller and some of them the mainboardcontroller. All systems are 
using IDE.

But i cannot say what happens to these machines at the time of failure. 
Sometimes these servers crashed directly after a few minutes. Sometimes 
they run about 2-3 days... i've now downgraded all servers to 2.6.16.37. 
Cause they are production machines... but i have one machine where we 
can test - if you need something.

Here is the output running 2.6.16.37 at the moment:
xfs_growfs -n /

meta-data=/dev/root              isize=256    agcount=16, agsize=603855 blks
          =                       sectsz=512   attr=0
data     =                       bsize=4096   blocks=9661680, imaxpct=25
          =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=4717, version=1
          =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

Stefan

David Chinner schrieb:
> On Sun, Jan 21, 2007 at 01:30:15PM +0100, Stefan Priebe - FH wrote:
>> Hello!
>>
>> I've 3 Servers which works wonderful with 2.6.16.X (also testet the
>> latest 2.6.16.37)
>>
>> but with 2.6.18.6 i get these errors:
> 
> [ EIP is at xfs_bmap_add_extent_hole_delay+0x58d/0x59b ]
> [ EIP is at generic_file_buffered_write+0x390/0x6cf ]
> 
> Do you have a reproducable test case for these? if not,
> do you have any idea what is going on in the system at the time
> of the failure?
> 
> Can you describe the storage subsystem you are using and post the
> output of xfs_growfs -n <mntpt> on the filesystem that is causing
> problems?
> 
> Cheers,
> 
> Dave.

