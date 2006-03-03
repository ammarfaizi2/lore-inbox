Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWCCW56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWCCW56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWCCW56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:57:58 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:50560 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932135AbWCCW55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:57:57 -0500
In-Reply-To: <20060303214036.11908.10499.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <54FF0817-23ED-47F1-8234-FD3079B3E403@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Date: Fri, 3 Mar 2006 16:58:01 -0600
To: Chris Leech <christopher.leech@intel.com>
X-Mailer: Apple Mail (2.746.2)
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


On Mar 3, 2006, at 3:40 PM, Chris Leech wrote:

> This patch series is the first full release of the Intel(R) I/O
> Acceleration Technology (I/OAT) for Linux.  It includes an in  
> kernel API
> for offloading memory copies to hardware, a driver for the I/OAT  
> DMA memcpy
> engine, and changes to the TCP stack to offload copies of received
> networking data to application space.
>
> These changes apply to DaveM's net-2.6.17 tree as of commit
> 2bd84a93d8bb7192ad8c23ef41008502be1cb603 ([IRDA]: TOIM3232 dongle  
> support)
>
> They are available to pull from
> 	git://198.78.49.142/~cleech/linux-2.6 ioat-2.6.17
>
> There are 8 patches in the series:
> 	1) The memcpy offload APIs and class code
> 	2) The Intel I/OAT DMA driver (ioatdma)
> 	3) Core networking code to setup networking as a DMA memcpy client
> 	4) Utility functions for sk_buff to iovec offloaded copy
> 	5) Structure changes needed for TCP receive offload
> 	6) Rename cleanup_rbuf to tcp_cleanup_rbuf
> 	7) Add a sysctl to tune the minimum offloaded I/O size for TCP
> 	8) The main TCP receive offload changes

How does this relate to Dan William's ADMA work?

http://marc.theaimsgroup.com/?t=113892936300001&r=1&w=2

- kumar
