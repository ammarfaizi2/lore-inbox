Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbULFV0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbULFV0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbULFV0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:26:01 -0500
Received: from math.ut.ee ([193.40.5.125]:42697 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261591AbULFVZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:25:55 -0500
Date: Mon, 6 Dec 2004 23:25:47 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
X-X-Sender: riinak@spartacus.at.mt.ut.ee
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org, mroos@ut.ee
Subject: Re: [PATCH 2.6] clean-up: fixes "unsigned>=0" warning
In-Reply-To: <41B4C93E.10203@nortelnetworks.com>
Message-ID: <Pine.SOC.4.61.0412062324590.14553@spartacus.at.mt.ut.ee>
References: <Pine.SOC.4.61.0412062247160.21075@math.ut.ee>
 <41B4C93E.10203@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that this one has been fixed somewhere between 2.6.8 and 2.6.9, so
it doesn't need to be fixed any more. Sorry for that.

Riina


On Mon, 6 Dec 2004, Chris Friesen wrote:

> Riina Kikas wrote:
>> This patch fixes warning "comparison of unsigned expression >= 0 is 
>> always true"
>> occuring on line 38
>> 
>> Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
>> 
>> --- a/fs/ntfs/collate.h    2004-10-18 21:53:06.000000000 +0000
>> +++ b/fs/ntfs/collate.h    2004-12-04 13:26:03.000000000 +0000
>> @@ -37,7 +37,7 @@
>>      if (unlikely(cr != COLLATION_BINARY && cr != 
>> COLLATION_NTOFS_ULONG))
>>          return FALSE;
>>      i = le32_to_cpu(cr);
>> -    if (likely(((i >= 0) && (i <= 0x02)) ||
>> +    if (likely(cr <= 0x02 ||
>
> Do we really want to be doing any operations on "cr", since it's not 
> known what endianness of cpu we're on?
>
> Chris
>
