Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUFBDIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUFBDIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 23:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264785AbUFBDIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 23:08:16 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:30216 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264746AbUFBDIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 23:08:14 -0400
Message-ID: <40BD444D.2070305@steeleye.com>
Date: Tue, 01 Jun 2004 23:06:53 -0400
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: fix device names
References: <4034FDD0.33BC57AF@SteelEye.com>	<40BC8C49.4020602@steeleye.com> <20040601163234.029af1b6.akpm@osdl.org>
In-Reply-To: <20040601163234.029af1b6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Paul Clements <paul.clements@steeleye.com> wrote:
> 
>>It seems more appropriate to call the devices "nbX" rather than "nbdX",
>>since that's what the device nodes are actually named.
> 
> 
> This affects /proc/partitions, /proc/diskstats, and probably other things. 

Network block devices don't actually show up in /proc/partitions, but 
you have a valid point that the other uses would change. Although, I 
think it's a change for the better.

> I think it's too late to change it.

Fair enough. I can live with this discrepancy, although I think nbd is 
the only block device driver that has this problem. That's the only 
reason I sent the patch along...just trying to make nbd consistent with 
all the other device drivers.

Thanks,
Paul
