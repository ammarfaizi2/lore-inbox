Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUJGVLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUJGVLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUJGVIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:08:01 -0400
Received: from magic.adaptec.com ([216.52.22.17]:6303 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S268141AbUJGUiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:38:52 -0400
Message-ID: <4165A951.3060808@adaptec.com>
Date: Thu, 07 Oct 2004 16:38:41 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
References: <1097178019.24355.39.camel@localhost> <4165A369.60306@cybsft.com>
In-Reply-To: <4165A369.60306@cybsft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2004 20:38:49.0088 (UTC) FILETIME=[A632C000:01C4ACAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Dave Hansen wrote:
> 
>> I just booted 2.6.9-rc3-mm3 and got the good ol'
>> VFS: Cannot open root device "sda2" or unknown-block(0,0)
>> Please append a correct "root=" boot option
>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>> unknown-block(0,0)
>>
>> backing out bk-scsi.patch seems to fix it.  I believe this worked in
>> 2.6.9-rc3-mm2.
>>
>> -- Dave
> 
> 
> While I can't verify that backing out bk-scsi.patch fixes it for me yet, 
> I can verify that I get the exact same error trying to boot this kernel. 
> I too am using the aic7xxx.

It is most likely the PCI ID patch which went into those drivers.
You can back out only that change (drivers/scsi/aic7xxx) and
try it.  (assuming you haven't changed anything else)

	Luben



