Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277756AbRJIPB4>; Tue, 9 Oct 2001 11:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277757AbRJIPBr>; Tue, 9 Oct 2001 11:01:47 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:56708 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277756AbRJIPBo>; Tue, 9 Oct 2001 11:01:44 -0400
Message-ID: <3BC3118B.8050001@wipro.com>
Date: Tue, 09 Oct 2001 20:32:35 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: is reparent_to_init a good thing to do?
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I was looking at the driver under drivers/net/8139too.c, a kernel
thread rtl8139_thread is created, it calls daemonize() and soon
afterwards calls reparent_to_init(). Looking at reparent_to_init(),
it looks like all kernel threads should do this. But, I feel I am missing
something, since not everybody does this.

Is this a good thing to do? or are there special cases when we need this.

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
