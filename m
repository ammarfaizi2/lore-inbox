Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbVLRUHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbVLRUHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbVLRUHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:07:14 -0500
Received: from mail.avalus.com ([195.82.114.197]:62088 "EHLO shed.alex.org.uk")
	by vger.kernel.org with ESMTP id S965277AbVLRUHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:07:12 -0500
Date: Sun, 18 Dec 2005 20:07:08 +0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Michael Madore <michael.madore@gmail.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PCI-DMA: high address but no IOMMU (still there)
Message-ID: <92C54DAE01BADE27ACF9C370@[192.168.100.25]>
In-Reply-To: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
X-Mailer: Mulberry/4.0.4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 27 October 2005 10:47 -0700 Michael Madore <michael.madore@gmail.com> 
wrote:

> Hi,
>
> I am seeing the following errors in /var/log/messages when booting
> 2.6.14-rc5 on a dual Opteron nforce4 motherboard with 8GB of RAM:

For the record, I was seeing the same problem with 2.6.15-rc5 (it
wasn't there on 2.6.12), but the thread I'm replying to isolated the
problem patch.

A workaround here (Phoenix BIOS, Dual Opteron 275, 8GB RAM, 1.02.2895,
Tyan Thunder K8WE (S2895)) is to set the following in BIOS:

* Set Operating System to "Linux"
* Hammer Configuration->Memory Hole->IOMMU set to Enable
* Hammer Configuration->MTRR mapping set to "Discrete"

No idea why this fixes it, nor why it wasn't necessary before,
but it at least boots now.

It hangs in a pretty cryptic way on a default config kernel (well, Ubuntu
Dapper defaults) so it would be nice if this was resolved.

--
Alex Bligh
