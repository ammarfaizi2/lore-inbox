Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWC3T5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWC3T5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWC3T5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:57:42 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:9684 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750778AbWC3T5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:57:41 -0500
In-Reply-To: <c0a09e5c0603301036s4e9a63e5v476d89ff8ba37760@mail.gmail.com>
References: <20060329225505.25585.30392.stgit@gitlost.site> <20060329225548.25585.73037.stgit@gitlost.site> <8C52750C-8BC3-4815-834C-6DBEA714BA0F@kernel.crashing.org> <c0a09e5c0603301036s4e9a63e5v476d89ff8ba37760@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <351C5BDA-D7E3-4257-B07E-ABDDCF254954@kernel.crashing.org>
Cc: "Chris Leech" <christopher.leech@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Date: Thu, 30 Mar 2006 13:57:51 -0600
To: Andrew Grover <andy.grover@gmail.com>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 30, 2006, at 12:36 PM, Andrew Grover wrote:

> On 3/30/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>> What is the utility of exporting memcpy_count, and bytes_transferred
>> to userspace via sysfs?  Is this really for debug (and thus should be
>> under debugfs?)
>
> Well....it's true they're useful for debugging but I would put them in
> the category of system statistics that shouldn't go in debugfs. I
> think they are like /proc/interrupts' interrupt counts or the TX/RX
> stats reported by ifconfig.

Fair, but wouldn't it be better to have the association per client.

Maybe leave the one as a summary and have a dir per client with  
similar stats that are for each client and add a per channel summary  
at the top level as well.

- kumar

