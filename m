Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275398AbRJJLI3>; Wed, 10 Oct 2001 07:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275399AbRJJLIJ>; Wed, 10 Oct 2001 07:08:09 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:53663 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S275398AbRJJLIF>; Wed, 10 Oct 2001 07:08:05 -0400
Message-ID: <3BC42C41.90809@wipro.com>
Date: Wed, 10 Oct 2001 16:38:49 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] register_blkdev and unregister_blkdev
In-Reply-To: <Pine.GSO.4.21.0110100651080.17790-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:

>All module init code is under BKL and will stay that way for a long time.
>If that ever becomes not true, we are in for much more pain that
>register_blkdev() races - you would need to do audit of all drivers to
>pull something like that.
>

I suspected that the locking in init_module was preventing bad
things from happening in {devfs_}register_blkdev, I am sure now.

Balbir


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
