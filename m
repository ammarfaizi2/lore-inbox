Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbREMRPM>; Sun, 13 May 2001 13:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbREMRPB>; Sun, 13 May 2001 13:15:01 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:30004 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S261472AbREMROr>; Sun, 13 May 2001 13:14:47 -0400
Message-ID: <3AFEC0FB.8080705@blue-labs.org>
Date: Sun, 13 May 2001 10:14:35 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Ed Okerson <eokerson@quicknet.net>
Subject: Re: [PATCH] drivers/telephony/phonedev.c (brings this code up to date with Quicknet CVS)
In-Reply-To: <E14yygK-0006fu-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alrighty.  That eliminates the patch.  I'll rewrite the ixj.c according 
to this.  ixj.c will be a large patch due to the numerous revisions, I 
don't know how well it can be broken up into small pieces.  Do you want 
small pieces still?  The ChangeLog shows all the fixes for the 
revisions.  There have been 68 revisions since the version listed in the 
kernel's tree.

David

Alan Cox wrote:

>>phonedev.diff is against 2.4.4 and brings the file phonedev.c up to date 
>>with respect to the Quicknet CVS.  Changes are very minor, mostly #if 
>>LINUX_VERSION_CODE matching and structure updates.  Small off by one 
>>fixes and file operation semantics updates.
>>
>
>I intentionally dont keep back compat glue in the mainstream kernel
>
>>@@ -101,20 +134,25 @@
>> 
>> 	if (unit != PHONE_UNIT_ANY) {
>> 		base = unit;
>>-		end = unit + 1;  /* enter the loop at least one time */
>>+		end = unit;
>>
>
>This unfixes a bug too.
>
>All rejected
>


