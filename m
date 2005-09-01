Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVIAUGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVIAUGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVIAUGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:06:20 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:37125 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030357AbVIAUGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:06:18 -0400
Message-ID: <43176095.1000805@tmr.com>
Date: Thu, 01 Sep 2005 16:12:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB Storage speed regression since 2.6.12
References: <20050901113614.GA63@DervishD>
In-Reply-To: <20050901113614.GA63@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi all :)
> 
>     I don't know if this is a known issue, but usb-storage speed for
> 'Full speed' devices dropped from 2.6.11.12 (more than 800Kb/s) to
> 2.6.12 (less than 250Kb/s). The problem still exists in 2.6.13.
> 
>     The lack of speed seems to affect only the OHCI driver. My test
> was done over a PCI USB 2.0 card, ALi chipset, OHCI driver (well
> EHCI+OHCI) and using a full speed device capable of 12MBps. The
> average measured speeds are:
> 
>     - 2.4.31:           about 450Kb/seg
>     - 2.6.11-Debian:    about 800Kb/seg
>     - 2.6.11.12:        about 820Kb/seg
>     - 2.6.12.x:         about 200Kb/seg
>     - 2.6.13:           about 200Kb/seg
> 
>     The .config is more or less the same in all kernels. I've took a
> look at the ChangeLog for 2.6.12 and there are lots of changes in the
> USB subsystem but I cannot identify which one could be the culprit.
> 
I see a worse problem, I load the driver, mount the filesystems on the 
USB 160GB disk, and the disk just "goes away." I see the devices in 
/proc/scsi/scsi but I can't access the devices any more. Definitely time 
for a fallback to a more stable kernel!
