Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVFMVmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVFMVmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVFMVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:42:21 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:64921 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261426AbVFMVkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:40:47 -0400
Date: Mon, 13 Jun 2005 23:40:39 +0200
From: Voluspa <lista1@telia.com>
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: mouse still losing sync and thus jumping around
Message-Id: <20050613234039.7d3ed895.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-02-23 16:53:04 Dmitry Torokhov wrote:
> On Wed, 23 Feb 2005 17:29:49 +0100, Nils Kalchhauser wrote:
[...]
>> it seems to me like it is connected to disk activity... is that
>> possible?

> Yes, It usually happens either under high load, when mouse interrupts
> are significantly delayed. Or sometimes it happen when applications
> poll battey status and on some boxes it takes pretty long time. And
> because it is usually the same chip that serves keyboard/mouse it
> again delays mouse interrupts.

My notebook is an Acer Aspire 1520 (1524) with a Synaptics Touchpad,
model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000

Kernels 2.6.11.11 and 2.6.12-rc6
Synaptics driver 0.14.2

The "lost sync at byte" and "driver resynched" began flooding the logs
when I enabled Sensors --> Temperatures --> thermal_zone [THRC/THRS] in
the system monitor gkrellm. I haven't tried battery monitoring.

There are only occasional mouse pointer jumps, but the logfiles grow
very quickly. I tried reducing the gkrellm updates from 10 times a
second to 2, but it only had a marginal effect. It seems a bit silly
that this powerful notebook (AMD64 Athlon 3400+) can't 'multitask'
correctly.

I thought about just erasing the warning messages from the kernel
source (don't want to disable warn in syslog completely), but when I
found the gkrellm culprit I turned off the monitoring instead,
reluctantly.

My system has no taxing desktop, just a window manager.

Mvh
Mats Johannesson
--
