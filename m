Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWJFDRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWJFDRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 23:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbWJFDRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 23:17:23 -0400
Received: from mail.tmr.com ([64.65.253.246]:54763 "EHLO roadwarrior3.tmr.com")
	by vger.kernel.org with ESMTP id S1751739AbWJFDRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 23:17:23 -0400
Message-ID: <45231A63.3020102@tmr.com>
Date: Tue, 03 Oct 2006 22:20:19 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: dell poweredge 2400 harddisks going into offline mode when heavy
 I/O occurs
References: <20060928141923.GH9348@vanheusden.com> <20060928151257.GA18268@lists.us.dell.com>
In-Reply-To: <20060928151257.GA18268@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Thu, Sep 28, 2006 at 04:19:23PM +0200, Folkert van Heusden wrote:
>> Hi,
>>
>> I have a Dell Poweredge 2400 with 6 scsi harddisks in (hw-) raid 5.
>> 512MB ram, 2x P3.
>> When heavy disk i/o occurs, the system puts the harddisks into offline
>> mode causing the filesystems to be put in readonly. The current kernel
>> is 2.6.8, with 2.4.27 this did not occure. Googling did not help. The
>> disks all have green lights (there's a special led for each to indicate
>> errors - that one is off).
> 
> [snip]
>> Sep 28 16:05:12 kasparov kernel: aacraid: Host adapter reset request. SCSI hang ?
>> Sep 28 16:06:12 kasparov kernel: aacraid: SCSI bus appears hung
>> Sep 28 16:06:12 kasparov kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
> 
> Yes, this is familiar. See:
> 
> http://lists.us.dell.com/pipermail/linux-poweredge/2004-May/014694.html
> 
> In addition, please consider mounting your file systems with
> 'noatime', as this reduces the number of small writes being sent to
> the disks.
> 
> 2.6.x kernels have the ability to swamp the RAID controller firmware
> with requests where 2.4.x kernels couldn't so easily.

Can you configure the controller as JBOD and use software raid. Would 
the controller keep up with that?
> 
> Thanks,
> Matt
> 


