Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbWJ3Pdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbWJ3Pdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbWJ3Pdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:33:38 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:51645 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030533AbWJ3Pdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:33:38 -0500
Message-ID: <45461B59.2060607@cfl.rr.com>
Date: Mon, 30 Oct 2006 10:33:45 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Background scan of sata drives
References: <453EDF44.3090308@cfl.rr.com> <45459B10.6080702@gmail.com>
In-Reply-To: <45459B10.6080702@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2006 15:33:42.0224 (UTC) FILETIME=[C782BD00:01C6FC38]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14782.003
X-TM-AS-Result: No--13.910700-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could have sworn I saw a patch in the last month or two that made the 
modprobe scan NON blocking, and added a new dummy module you could 
modprobe that would block until the scan was complete.  Am I imagining this?

Tejun Heo wrote:
> Phillip Susi wrote:
>> I seem to recall seeing mention flow by on the lkml at some point that 
>> sata disks are now scanned in the background rather than blocking in 
>> the modprobe, but that there is a new dummy module you can load that 
>> just blocks until all drives have been scanned.  I tried but was 
>> unable to find the thread that mentioned this, so does anyone know 
>> what that module was?
> 
> Scanning during boot and module loading is blocking.  modprobe will wait 
> in the kernel until the initial scan is complete.  But user initiated 
> scan (echo - - - > /sys/class/scsi_host/hostX/scan) doesn't wait for 
> completion.  Patch to make user scan blocking is pending.
> 

