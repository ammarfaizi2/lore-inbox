Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbTFCJSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 05:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbTFCJSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 05:18:49 -0400
Received: from ftp-xb.sasken.com ([164.164.56.3]:54723 "EHLO
	sandesha.sasken.com") by vger.kernel.org with ESMTP id S264855AbTFCJSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 05:18:48 -0400
Date: Tue, 3 Jun 2003 15:06:42 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: problem with VLAN tagged ICMP
Message-ID: <Pine.LNX.4.33.0306031459280.10611-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi

I am writing a device driver that can send VLAN Tagged packets on
linux-2.4.19. I have written a function mydev_hard_header() and assigned
dev->hard_header to mydev_hard_header.

The function mydev_hard_header() creates ethernet header + VLAN header, if
the packet is not already tagged.

When I tried ping on this device, I am seeing that the first 6-7 packets
are tagged and later, they are all going untagged. mydev_hard_header()
function is also not being called for these packets. I have also confirmed
that the control is not going to mydev_rebuild_hard_header() function.

ARP packets are always getting tagged. This problem is seen only with ICMP.

Any guesses why this could be happening? Could there be any cache-related
issues?

Thanks & regards
Madhavi.

Madhavi Suram
Software Engineer
Customer Delivery / Networks
Sasken Communication Technologies Limited
139/25, Ring Road, Domlur
Bangalore - 560071 India
Email: madhavis@sasken.com
Tel: + 91 80 5355501 Extn: 8062
Fax: + 91 80 5351133
URL: www.sasken.com


--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

************************************************************************

SASKEN BUSINESS DISCLAIMER

This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.

***********************************************************************

--=_IS_MIME_Boundary--
