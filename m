Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRJDKLB>; Thu, 4 Oct 2001 06:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273507AbRJDKKv>; Thu, 4 Oct 2001 06:10:51 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:51680 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S273487AbRJDKKh>; Thu, 4 Oct 2001 06:10:37 -0400
Message-ID: <3BBC35BC.5020706@wipro.com>
Date: Thu, 04 Oct 2001 15:41:08 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: James.Bottomley@HansenPartnership.com, jes@sunsite.dk,
        linuxopinion@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain> <20011003.172439.66056954.davem@redhat.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With Rik's reverse mapping patch, wouldn't we have the virtual address for the given
physical address ? I have no clue about how the patch works, somebody willing to explain
it?

Balbir

David S. Miller wrote:

>   From: James Bottomley <James.Bottomley@HansenPartnership.com>
>   Date: Wed, 03 Oct 2001 17:44:18 -0500
>
>   (although I can see it may be expensive to walk iommu page tables)
>
>I know of hardware where doing the reverse mapping would not even be
>possible, the page tables are in hardware registers and are "write
>only".  This means you can't even read the PTEs back, you'd have to
>keep track of them in software and that is totally unacceptable
>overhead when it won't even be used %99 of the time.
>
>The DMA API allows us to support such hardware cleanly and
>efficiently, but once we add this feature which "everyone absolutely
>needs" we have a problem with the above mentioned piece of hardware.
>
>Franks a lot,
>David S. Miller
>davem@redhat.com
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
