Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVHYTVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVHYTVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVHYTVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:21:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751230AbVHYTVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:21:40 -0400
Date: Thu, 25 Aug 2005 12:21:26 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Manuel Schneider <root@80686-net.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about usb-storage: Sometimes partitions are not
 recognized.
Message-Id: <20050825122126.47fe659b.zaitcev@redhat.com>
In-Reply-To: <mailman.1124977260.20356.linux-kernel2news@redhat.com>
References: <mailman.1124977260.20356.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005 15:26:27 +0200, Manuel Schneider <root@80686-net.de> wrote:

> When I plug them in, they will be recognized by hotplug (I'm using udev), the 
> module usb-storage will be loaded and the device nodes are created.
> 
> BUT: There is normally just ONE device node for the disc block device.
> Partitions are not available.
> I can "solve" this by just starting fdisk (and shutting it down again without 
> changing anything) on the given block device - after that, all the partitions 
> are available. [...]

We need more data. First, "Kernel 2.6.x" is not good enough.
Give us a precise version on which you observe this.
Second, running with CONFIG_USB_STORAGE_DEBUG may yield a useful trace.
I am not quite sure about that though, as this seems to be some
misunderstanding between the block level and SCSI.

Problems with block device open() not working right fall squarely
into purview of Al Viro, but he's quite busy right now. Someone
has to identify the exact scenario. I suppose adding a few printks
around fs/block_dev.c may be more beneficial than any USB debugging.

-- Pete

