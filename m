Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTJWMwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 08:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTJWMwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 08:52:13 -0400
Received: from intra.cyclades.com ([64.186.161.6]:7368 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263565AbTJWMwL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 08:52:11 -0400
Date: Thu, 23 Oct 2003 10:47:13 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: vwake <vwake@indiatimes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High Utilization kswapd and kupdated in Large memory system 
In-Reply-To: <200310231005.PAA20811@WS0005.indiatimes.com>
Message-ID: <Pine.LNX.4.44.0310231046180.1443-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Oct 2003, vwake wrote:

> Hi,
> On large memory machine ( 32 GB RAM) any continuous disk activity puts kswapd and kupdated to 99% utilization and eventually ( in about 10 mins) brings down the whole machine.
> 
> The machine works well when the memory was set at 4GB using the 'mem="
> entry on grub.conf. The same disk operations succeed when kept in this
> config.
> 
> 
> The kernel is version 2.4.22 stable downloaded from kernel.org, and compiled with 64GB option enabled. The machine is installed with Redhat Linux 9.0.
> 
> No errors gets logged anywhere and also there are no console error
> messages. The machine eventually gets locked up, and only a hard reset
> will bring it back into shape. I do not suspect the hardware because it
> is reproduceable in a different machine with similar hardware config.
>
> 
> The hardware config as below:
> 
> Dell PE 6650 / 4* Xeon 2GHz / 32 GB RAM / 500 GB Raid 5 on PERC 3DC ( AMI megaraid driver) 6 DISCS / 2* Broadcom 100/1000 NIC ( bcm5700 driver) 
> 
> The system has / and /boot in ext3 and rest in ReiserFS. The 500 GB data partition is in ReiserFS.
> 
> The problem is reproducible by just copying some large data ( 3-5 GB ) to any of the filesystems.
> One observation ( may not be useful) is that the symptoms starts after the cached memory in /proc/meminfo goes beyond 16GB !
> 
> 
> I had tried changing the "elvtune" parameters to " -r 4096 -w 8192" as adviced in some of the archived maillist mails. But this didnt help !
> 
> Please let me know if any further information is needed from the machine.

Hi, 

Can you please try 2.4.23-pre?

There have been significant highmem balancing changes.



