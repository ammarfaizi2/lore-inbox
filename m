Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRKCKzV>; Sat, 3 Nov 2001 05:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKCKzM>; Sat, 3 Nov 2001 05:55:12 -0500
Received: from wiproecmx2.wipro.com ([164.164.31.6]:46574 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S280938AbRKCKzB>; Sat, 3 Nov 2001 05:55:01 -0500
Reply-To: <sivakumar.kuppusamy@wipro.com>
From: "Sivakumar Kuppusamy" <sivakumar.kuppusamy@wipro.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: VM: Killing process
Date: Fri, 2 Nov 2001 16:49:01 +0530
Message-ID: <001901c16390$2c815b40$5f08720a@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi All,
We are getting the message "VM: Killing process pimd" when we are
running our application pimd. Found from somewhere that this a OOM
situation. We used a memory leak finding tool "ccmalloc" and found
that our applicaition is not leaking any memory. 

Info abt pimd:
Our application is interacting with the kernel, which(kernel) will 
give the packets it received from the network to the "pimd"
through a socket(for taking some decisions). This happens only when 
the packets arrive at a high data rate(say 100MBPS in ethernet LAN).
We found that during this happens, the kernel is giving each packet
(multicast) it receives to the application and the application is 
dropping it. 

After sometime we get a message "VM:killing process pimd" and pimd
gets killed. Or we get message for every packet saying copy_to_user()
failed. 

Is this a 
- memory leakage problem with our application or
- Memory leakage with the kernel patches we made or
- due to packets coming at the very high rate and each packet 
  is sent to user thru a socket which eventually might get full.

Any idea on how to handle(avoid) this? Are we not supposed to send
packets at this high rate to the user space? 

Thanks in advance
Siva

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
