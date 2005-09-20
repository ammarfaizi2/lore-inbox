Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbVITOVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbVITOVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbVITOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:21:00 -0400
Received: from mout1.freenet.de ([194.97.50.132]:12933 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932757AbVITOU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:20:59 -0400
Message-ID: <43301A98.5010607@zaphods.net>
Date: Tue, 20 Sep 2005 16:20:08 +0200
From: Stefan Schmidt <zaphodb@zaphods.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc1-mm1 unable to mount root on HP Smart6i cciss was: Re:
 2.6.14-rc1-mm1
References: <4NkHQ-cw-13@gated-at.bofh.it>
In-Reply-To: <4NkHQ-cw-13@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Changes since 2.6.13-mm3:
...
> -cciss-new-controller-pci-subsystem-ids.patch
> -cciss-busy_initializing-flag.patch
> -cciss-new-disk-register-deregister-routines.patch
> -cciss-direct-lookup-for-command-completions.patch
> -cciss-bug-fix-in-cciss_remove_one.patch
> -cciss-fix-for-dma-brokeness.patch
> -cciss-one-button-disaster-recovery-support.patch
> -cciss-scsi-tape-info-for-proc.patch

On a HP Proliant DL385 with Smart6i Controller 2.6.14-rc1-mm1 was unable 
to mount root although the device file existed and had the correct 
major/minor numbers. 2.6.13-vanilla was able to find and mount the very 
same root-device using the same config.
Root-device was the first partition the first SCSI disk exported as JBOD 
which in smart-controller terms means it is a raid0. /dev/cciss/c0d0p1
I was able to see the devices flying by during the booting of 
2.6.14-rc1-mm1 so the controller, its disks and partitions were 
recognized correctly, it was just unable to map the major/minor number 
to a device or partition.

best regards,

  Stefan Schmidt
