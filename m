Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUBYQT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUBYQS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:18:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261409AbUBYQRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:17:53 -0500
Message-ID: <403CCAA2.5070800@pobox.com>
Date: Wed, 25 Feb 2004 11:17:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Joy <mdj00b@acu.edu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 Boot Failure on Nforce2 Board
References: <1077723571.9844.22.camel@physx01.acu.edu>
In-Reply-To: <1077723571.9844.22.camel@physx01.acu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Joy wrote:
> Hello,
> We're having an interesting problem with the latest kernel release. On
> an Albatron KM18G, latest bios, 1024MB system with athlon xp proc, 2.6.3
> refuses to boot. It hangs on initializing the ide devices.
> 
> [2.] Full description of the problem/report: The problem is most
> definately related to the ide controller changes made in 2.6.3 as in
> 2.4.22 we did not have this issue. We haven't tried any of the previous
> kernels as this is a production system.
> 
> When booting the 2.6.3 kernel, either compiled by Mandrake (cooker) or
> using the straight up source, the kernel hangs without any error on hda:
> max request size : 128KiB.
> 
> I don't have a log of this as it won't initialize the HD (wd1200jb on an
> 80pin cable) to log the dmesg dump. Anyways we have two identical
> machines that do this. Both are nforce2 integrated gpu's, using onboard
> networking and sound. They have 2x512 Kingston HyperX memory modules
> which have been thouroughly tested in these machines with memtest and no
> errors are found.
> 
> Of note is that these machines exhibit the random freezes (blank screen,
> hard lock, normally associated with heavy disk thrashing) many other
> nforce2 boards seem to be experiencing. To fix this, we boot them with
> the noapic and nolapic option and the problem does not reappear. 

> i2c-nforce2             4392   0 (unused)

> nvnet                  30880   1 (autoclean)


You appear to have a binary-only module, nvnet, loaded...  we cannot 
debug problems with closed source code in your kernel.  Try "forcedeth" 
NIC driver instead.

	Jeff



