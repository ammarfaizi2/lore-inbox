Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276897AbRJHODR>; Mon, 8 Oct 2001 10:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276899AbRJHOC6>; Mon, 8 Oct 2001 10:02:58 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:50575 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S276897AbRJHOCu>; Mon, 8 Oct 2001 10:02:50 -0400
Message-ID: <3BC1B23C.1070400@wipro.com>
Date: Mon, 08 Oct 2001 19:33:40 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Sebastian Heidl <heidl@zib.de>, linux-kernel@vger.kernel.org
Subject: Re: implementation of SIOCGIFFCOUNT
In-Reply-To: <20011008155237.C811@csr-pc1.zib.de>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pass '0' as the size argument and u will get the total size (sizeof struct * number of interfaces)
back. The only thing is u have to make two calls, which u would do anyway.

Balbir

Sebastian Heidl wrote:

>Hi,
>
>is there a specific reason for SIOCGIFCOUNT not being implemented
>in  the kernel ? All occurences lead to net/core/dev.c dev_ioctl(...)
>which just returns -EINVAL for this command. So one has to guess
>the number of struct ifreq structures to pass to a SIOCGIFCONF
>call.
>
>enlighten me, please ;-)
>_sh_
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
