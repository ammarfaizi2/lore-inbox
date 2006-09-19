Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWISUFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWISUFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWISUFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:05:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18398 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751099AbWISUFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:05:16 -0400
Message-ID: <45104D79.5030001@us.ibm.com>
Date: Tue, 19 Sep 2006 13:05:13 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: dougg@torque.net
CC: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-Initiator SAS
References: <451041AA.4060702@us.ibm.com> <451048C4.2090706@torque.net>
In-Reply-To: <451048C4.2090706@torque.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:

> With the mptsas driver you can use smp_utils to look
> at that expander via /dev/mptctl ('modprobe mptctl' first).
> To get an overview of what the expander sees, try:
>  # smp_discover -mb /dev/mptctl

Unfortunately, I see this:

root@elm3a253:~# smp_discover -mb /dev/mptctl
MPTCOMMAND ioctl failed: No such device
ioctl failed
smp_send_req failed, res=-1

...a strace of the app reveals this:

stat("/dev/mptctl", {st_mode=S_IFCHR|0660, st_rdev=makedev(10, 220),
...}) = 0
open("/dev/mptctl", O_RDWR)             = 3
brk(0)                                  = 0x508000
brk(0x529000)                           = 0x529000
ioctl(3, 0xc0486d14, 0x508010)          = -1 ENODEV (No such device)

--D
