Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRJIIVQ>; Tue, 9 Oct 2001 04:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273691AbRJIIVG>; Tue, 9 Oct 2001 04:21:06 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:29864 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S273588AbRJIIVA>; Tue, 9 Oct 2001 04:21:00 -0400
Message-ID: <3BC2B399.8030000@wipro.com>
Date: Tue, 09 Oct 2001 13:51:45 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: "Paul E. McKenney" <pmckenne@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com> <3BC2A3B3.3020004@wipro.com> <20011009131626.A10410@in.ibm.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dipankar Sarma wrote:

>On Tue, Oct 09, 2001 at 12:43:55PM +0530, BALBIR SINGH wrote:
>
>>1) On Alpha this code does not improve performance since we end up using spinlocks
>>for my_global_data anyway, I think you already know this.
>>
>
>It may if you don't update very often. It depends on your
>read-to-write ratio.
>
>>The approach is good, but what are the pratical uses of the approach. Like u mentioned a newly
>>added element may not show up in the search, searches using this method may have to search again
>>and there is no way of guaranty that an element that we are looking for will be found (especially
>>if it is just being added to the list).
>>
>>The idea is tremendous for approaches where we do not care about elements being newly added.
>>It should definitely be in the Linux kernel  :-) 
>>
>
>Either you see the element or you don't. If you want to avoid duplication,
>you could do a locked search before inserting it.
>Like I said before, lock-less lookups are useful for read-mostly
>data. Yes, updates are costly, but if they happen rarely, you still benefit.
>
How does this compare to the Read-Copy-Update mechanism? Is this just another way of implementing
it, given different usage rules.

Balbir


>
>Thanks
>Dipankar
>




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
