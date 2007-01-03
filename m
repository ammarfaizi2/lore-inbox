Return-Path: <linux-kernel-owner+w=401wt.eu-S1750728AbXACMUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXACMUn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 07:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbXACMUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 07:20:43 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:45941 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXACMUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 07:20:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=fFz0GbP9P1gHxWYyPvrleryd3lGgUPmWb5egaSyoKehcMJNs3VYJz+j2S8uqm9F6Q8M3VkjW6M9LPoxHEQnJ6uGPwX7s5xa8kG+muwuZoDwnQbFLY6Rf15RST23JcrhfP7wf5jqBBmMQMxYecpH9cqqMoLr1dnPbagAgU7EYQxI=
Message-ID: <459B9F91.9070908@gmail.com>
Date: Wed, 03 Jan 2007 21:20:33 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Pablo Sebastian Greco <lkml@fliagreco.com.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems
References: <459A674B.3060304@fliagreco.com.ar>
In-Reply-To: <459A674B.3060304@fliagreco.com.ar>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Sebastian Greco wrote:
> First of all, thanks for everything, and my excuses if I'm doing
> anything wrong, this is my first lkml mail, but I've read all the faq,
> so should be OK.
> This is the machine with the problem:
> 
> Intel ServerBoard S5000VSA
> Dual Core Xeon 2.66 (Intel(R) Xeon(TM) CPU 2.66GHz stepping 04)
> 4G Kingston
> 1 Seagate 80G sata (ST380211AS) (sda)
> 3 Samsung 250G sata (SAMSUNG SP2504C) (sdb,c,d)
> 
> Installed distribution is FC6 x86_64
> 
> I've been getting these messages with distribution and vanilla kernels
> 
> Jan  1 16:29:08 squid kernel: ata4.00: exception Emask 0x0 SAct
> 0x7fffffff SErr 0x0 action 0x2 frozen
> Jan  1 16:29:08 squid kernel: ata4.00: cmd
> 61/60:00:c9:6d:8e/00:00:0e:00:00/40 tag 0 cdb 0x0 data 49152 out
> Jan  1 16:29:08 squid kernel:          res
> 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Jan  1 16:29:08 squid kernel: ata4.00: cmd
> 60/08:08:f7:7d:56/00:00:0e:00:00/40 tag 1 cdb 0x0 data 4096 in
> Jan  1 16:29:08 squid kernel:          res
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> <snip>
> Jan  1 16:29:08 squid kernel: ata4: soft resetting port
> Jan  1 16:29:08 squid kernel: ata4: softreset failed (port busy but CLO
> unavailable)
> Jan  1 16:29:08 squid kernel: ata4: softreset failed, retrying in 5 secs
> Jan  1 16:29:13 squid kernel: ata4: hard resetting port
> Jan  1 16:29:21 squid kernel: ata4: port is slow to respond, please be
> patient (Status 0x80)
> Jan  1 16:29:43 squid kernel: ata4: port failed to respond (30 secs,
> Status 0x80)
> Jan  1 16:29:43 squid kernel: ata4: COMRESET failed (device not ready)
> Jan  1 16:29:43 squid kernel: ata4: hardreset failed, retrying in 5 secs
> Jan  1 16:29:48 squid kernel: ata4: hard resetting port
> Jan  1 16:29:49 squid kernel: ata4: SATA link up 3.0 Gbps (SStatus 123
> SControl 300)
> Jan  1 16:29:49 squid kernel: ata4.00: configured for UDMA/133
> Jan  1 16:29:49 squid kernel: ata4: EH complete
> Jan  1 16:29:49 squid kernel: SCSI device sdd: 488397168 512-byte hdwr
> sectors (250059 MB)
> Jan  1 16:29:49 squid kernel: sdd: Write Protect is off
> Jan  1 16:29:49 squid kernel: SCSI device sdd: write cache: enabled,
> read cache: enabled, doesn't support DPO or FUA
> 
> lots of them, and eventually crashing the system.
> Tested from fc6 2.6.18 kernel to vanilla 2.6.20-rc2-mm1. Old kernels
> just crash, newer ones log these things and then crash.
> I don't want to flood with this mail with useless info, so please tell
> me what to send and I'll do it (dmesg, smartctl... you name it)
> BTW, memtest was running for about 2 days without errors, and and
> badblocks on all 4 drives returned nothing. Reallocated_Sector_Ct
> raw_value was 0 on all 4 drives

Please post full dmesg and the result of 'lspci -nnvvv'.  And what do
you mean by 'crash'?

-- 
tejun
