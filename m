Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRJJFRM>; Wed, 10 Oct 2001 01:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274774AbRJJFRD>; Wed, 10 Oct 2001 01:17:03 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:62426 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S274752AbRJJFQs>; Wed, 10 Oct 2001 01:16:48 -0400
Message-ID: <3BC3D9ED.6050901@wipro.com>
Date: Wed, 10 Oct 2001 10:47:33 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com> <20011010040502.A726@athlon.random> <9q0ku6$175$1@penguin.transmeta.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

>In article <20011010040502.A726@athlon.random>,
>Andrea Arcangeli  <andrea@suse.de> wrote:
>
>>On Tue, Oct 09, 2001 at 08:45:15AM -0700, Paul McKenney wrote:
>>
>>>Please see the example above.  I do believe that my algorithms are
>>>reliably forcing proper read ordering using IPIs, just in an different
>>>way.  Please note that I have discussed this algorithm with Alpha
>>>architects, who believe that it is sound.
>>>
>>The IPI way is certainly safe.
>>
>
>Now, before people get all excited, what is this particular code
>actually _good_ for?
>
>Creating a lock-free list that allows insertion concurrently with lookup
>is _easy_.
>
>But what's the point? If you insert stuff, you eventually have to remove
>it. What goes up must come down. Insert-inane-quote-here.
>
>And THAT is the hard part. Doing lookup without locks ends up being
>pretty much worthless, because you need the locks for the removal
>anyway, at which point the whole thing looks pretty moot.
>
>Did I miss something?
>
>		Linus
>

What about cases like the pci device list or any other such list. Sometimes
you do not care if somebody added something, while you were looking through
the list as long as you do not get illegal addresses or data.
Wouldn't this be very useful there? Most of these lists come up
at system startup and change rearly, but we look through them often.

Me too, Did I miss something?

Balbir

>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
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
