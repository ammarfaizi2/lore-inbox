Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277318AbRJJQxo>; Wed, 10 Oct 2001 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277317AbRJJQxe>; Wed, 10 Oct 2001 12:53:34 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:58381 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S277315AbRJJQxY>; Wed, 10 Oct 2001 12:53:24 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402B9E015@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'adilger@turbolabs.com'" <adilger@turbolabs.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'xuan--lkml@baldauf.org'" <xuan--lkml@baldauf.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: dynamic swap prioritizing
Date: Wed, 10 Oct 2001 12:47:54 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	> I'd rather just have the statistic data in a regular file for ALL
disks,
	> and then send it to the kernel via ioctl or write to a special
file that
	> the kernel will read from.  I don't think it is critical to have
this
	> data right at boot time, since it would only be used for
optimizing I/O
	> access and would not be required for a disk to actually work.

	My idea of putting this info on swap was that when the disk is moved
from one system to another system, the statistics stays with the swap
itself. If the swap disk(partition) is put in a different system which has
different configuration(that which would affect the performance info on the
disk), then we can recompute the statistics, otherwise there is no need to
rerun the utility every time the swap disk is moved. 
	Also the kernel would be smart enough to know about the swap
performance without the need for an utility to invoked, to set the
parameters through IOCTL.


