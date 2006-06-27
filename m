Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWF0Jr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWF0Jr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWF0Jr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:47:59 -0400
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:54777
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751070AbWF0Jr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:47:58 -0400
Message-ID: <003701c699ce$c126b550$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "\"Robert Mueller\"" <robm@fastmail.fm>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <dax@gurulabs.com>, <brong@fastmail.fm>, <hch@infradead.org>,
       <rdunlap@xenotime.net>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm> <20060621222826.ff080422.akpm@osdl.org> <1151333338.2673.4.camel@mulgrave.il.steeleye.com>
Subject: Re: Areca driver recap + status
Date: Tue, 27 Jun 2006 17:47:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.2663
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
X-OriginalArrivalTime: 27 Jun 2006 09:41:21.0000 (UTC) FILETIME=[D8B93680:01C699CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robert Mueller,

Does arcmsr still has more than one value per file issue on it?
Maybe I am miss-understand the means of one value per file.
Please tell me the issue, thanks.
About the BE platform, Areca's user on linux sparc platform had ran this 
driver successfuly.
But I attempt to install linux system on ppc platform and run this driver 
for more long time testing this day.
I will patch PAE issue on pci_map_single again and handle SYNCHRONIZE_CACHE 
for your request.

Best Regards
Erich Chen
----- Original Message ----- 
From: "James Bottomley" <James.Bottomley@SteelEye.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <rdunlap@xenotime.net>; <hch@infradead.org>; <erich@areca.com.tw>; 
<brong@fastmail.fm>; <dax@gurulabs.com>; <linux-kernel@vger.kernel.org>; 
<linux-scsi@vger.kernel.org>; "Robert Mueller" <robm@fastmail.fm>
Sent: Monday, June 26, 2006 10:48 PM
Subject: Re: Areca driver recap + status


> On Wed, 2006-06-21 at 22:28 -0700, Andrew Morton wrote:
>> On Thu, 22 Jun 2006 14:18:23 +1000
>> "Robert Mueller" <robm@fastmail.fm> wrote:
>>
>> > The driver went into 2.6.11-rc3-mm1 here:
>> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110754432622498&w=2
>>
>> One and a half years.
>>
>> Would the world end if we just merged the dang thing?
>
> Not the world perhaps, but I'm unwilling to concede that if a driver
> author is given a list of major issues and does nothing, then the driver
> should go in after everyone gets impatient.
>
> The rules for inclusion are elastic and include broad leeway for good
> behaviour, but this would stretch the elasticity way beyond breaking
> point.
>
> The list of issues is here:
>
> http://marc.theaimsgroup.com/?l=linux-scsi&m=114556263632510
>
> Most of the serious stuff is fixed with the exception of:
>
> - sysfs has more than one value per file
> - BE platform support
> - PAE (cast of dma_addr_t to unsigned long) issues.
> - SYNCHRONIZE_CACHE is ignored.  This is wrong.  The sync cache in the
> shutdown notifier isn't sufficient.
>
> At least the sysfs files have to be fixed before it goes in ... unless
> you want to be lynched by Greg?
>
> What I could do is set up a holding tree for all the fixed ... but -mm
> is doing a good job of that at the moment.
>
> James
>
> 

