Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUBZOsB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUBZOsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:48:01 -0500
Received: from mail.turbolinux.co.jp ([210.171.55.67]:63759 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id S261769AbUBZOr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:47:59 -0500
Message-ID: <403E0563.9050007@turbolinux.co.jp>
Date: Thu, 26 Feb 2004 23:40:35 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
Organization: Turbolinx Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.2.1) Gecko/20030105
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<1077668801.2857.63.camel@cog.beaverton.ibm.com> <20040224170645.392abcff.akpm@osdl.org>
In-Reply-To: <20040224170645.392abcff.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> john stultz <johnstul@us.ibm.com> wrote:
> 
>>	Booting 2.6.3-mm3 on an x440 hangs the box during the SCSI probe after
>>the following:
>> 
>>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>>        <Adaptec aic7899 Ultra160 SCSI adapter>                 
>>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
>>                                                                
>>
>>I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
>>there as well. 
> 
> 
> Could you try reverting aic7xxx-deadlock-fix.patch?  Also, add
> initcall_debug to the boot command just so we know we aren't blaming the
> wrong thing.
> 
> Apart from that, gosh.  Maybe you could add just linus.patch and
> bk-scsi.patch, see if that hangs too?  Or just test the latest linus tree -
> the scsi changes were merged this morning.  Thanks.
> 

Problem patch is expanded-pci-config-space.patch.
x440 can not enable acpi by dmi_scan.
expanded-pci-config-space.patch need acpi support.
So, kernel can not get x440's xAPIC interrupt.


