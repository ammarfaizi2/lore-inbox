Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161336AbWG2COW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbWG2COW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161403AbWG2COW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:14:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:61872 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1161336AbWG2COV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:14:21 -0400
X-Sasl-enc: 3EMycEZHhkz0tf/+FqQGNLsW8Z9b10F8jnx2/8NgwVHJ 1154139259
Message-ID: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
From: "Robert Mueller" <robm@fastmail.fm>
To: "Bron Gondwana" <brong@fastmail.fm>, "erich" <erich@areca.com.tw>
Cc: "Greg KH" <greg@kroah.com>, "Dax Kelson" <dax@gurulabs.com>,
       "Theodore Bullock" <tbullock@nortel.com>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
References: <25E284CCA9C9A14B89515B116139A94D0C6DF1A4@zrtphxm0.corp.nortel.com> <20060728202749.GA23662@kroah.com> <20060729014801.GB5487@brong.net>
Subject: Re: Areca arcmsr kernel integration
Date: Sat, 29 Jul 2006 12:14:26 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Checking the recent posts it seems that there are two outstanding 
>> > issues
>> >
>> > > - PAE (cast of dma_addr_t to unsigned long) issues.
>> > > - SYNCHRONIZE_CACHE is ignored.  This is wrong.  The sync cache in 
>> > > the
>> >
>> > > shutdown notifier isn't sufficient.
>> >
>> > That said, we have been using an older version of the driver off the
>> > Areca website for some time now with no major issues (other than kernel
>> > update problems).
>> >
>> > Is it possible to get the driver integrated and fix these problems
>> > after?
>>
>> Why not fix them up and submit the corrected driver?  If no one wants to
>> put the effort into fixing these issues now, why would they do the work
>> later?

I believe these final issues have already been fixed:

---
http://marc.theaimsgroup.com/?l=linux-scsi&m=115226175822438&w=2

From: Erich Chen <erich@areca.com.tw>

  1- fix sysfs has more than one value per file
  2- PAE issues (cast of dma_addr_t to unsigned long)
  3- unblock SYNCHRONIZE_CACHE

Signed-off-by: Erich Chen erich@areca.com.tw
---

And another one after that that Andrew brought up:

http://marc.theaimsgroup.com/?l=linux-scsi&m=115259088411283&w=2

I see that all of this was in 2.6.18-rc1-mm2

---
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/announce.txt

 SCSI fixes.

-drivers-scsi-arcmsr-cleanups.patch
-areca-raid-linux-scsi-driver-update7.patch
-areca-raid-linux-scsi-driver-update7-fix.patch

 Folded into areca-raid-linux-scsi-driver.patch

+areca-sysfs-fix.patch

 Fix breakage due to sysfs API changes.
---

But I don't see anything in 2.6.18-rc2-mm1 or 2.6.18-rc2

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/announce.txt
http://kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.18-rc2

Rob

