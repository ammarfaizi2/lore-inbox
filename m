Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276899AbRJCHTu>; Wed, 3 Oct 2001 03:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276900AbRJCHTk>; Wed, 3 Oct 2001 03:19:40 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:18088 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S276899AbRJCHTe>; Wed, 3 Oct 2001 03:19:34 -0400
Message-ID: <3BBABC41.50203@wipro.com>
Date: Wed, 03 Oct 2001 12:50:33 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [QUESTION] ISA overhead
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With 2.5 coming soon, something about ISA has been bothering me.

All DMA has been limited to 16MB, this is ofcourse going to go
away with the PCI DMA patch which allows PCI-DMA to use all the
memory (4GB for 32 bit cards). All the setup of page-frames, etc
is done with the knowledge of ISA.

I was wondering if ISA should be treated as a special case in 2.5
and only if the ISA bus and/or ISA device is present should we do
the 16MB setup. Are there other devices (like MCA) limited to doing
16 MB or so of DMA?, if so they too should be handled as a special case.

I think this is the correct approach, now that all available devices
are almost PCI. The default DMA space should be 32 bit, with special
devices or buses like ISA being handled differently. The current code
should be hidden under a #ifdef and be enabled only if CONFIG_
ISA_DMA or something similar is set.

Comments, suggestions

Balbir

PS: Please do not worry about the attachment, I have no control over it.

"Accepting criticism is the fastest way to learn the right things"
- Just made it up (I am no longer scared of being flamed)



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
