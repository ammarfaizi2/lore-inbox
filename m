Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263133AbVCJUcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVCJUcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbVCJUcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:32:02 -0500
Received: from hfcmsw01.instinet.com ([198.178.39.150]:7951 "EHLO
	hfcmsw01.esn.instinet.com") by vger.kernel.org with ESMTP
	id S263024AbVCJUW6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:22:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: netdev= kernel boot commands and the Intel e1000 nic
Date: Thu, 10 Mar 2005 15:22:49 -0500
Message-ID: <13A26154A563124B876A26F0EF0CE1ED0213718A@HFCCINFEXCH501.AMERICAS.CORP.LOCAL>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: netdev= kernel boot commands and the Intel e1000 nic
Thread-Index: AcUlru3DbTL0S9jzSOCFszNfsXvBSA==
From: "Alex Upton" <AUpton@island.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Mar 2005 20:22:49.0904 (UTC) 
    FILETIME=[EE186300:01C525AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

For about 3.5 days now I've been trying to swap eth0 and eth1 devices
through use of the netdev kernel boot switch.

The scenario:

We have a system with onboard NICS and a PCI Intel e1000 Fiber NIC
installed. This particular system by default forces the NIC inside the
PCI slot to always default to eth0. We want to have ultimate control as
to which NIC is deemed worthy enough to become eth0. We are using an
entirely monolithic kernel via a PXE driven build and prefer not to
support use of modules.

Reading through the kernel-parameters.txt I found the "netdev=" command
which suggests the following usage:

  netdev=	NET] Network devices parameters
            Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
            Note that mem_start is often overloaded to mean
            something different and driver-specific.

We have tried the following methods based on this info and other peoples
examples found in google land without success.

netdev=21,0x2800,0xf6fa,0xf6fd,eth1
netdev=21,0x2800,0xf6fa0000,0xf6fd0000,eth1
netdev=21,0x2800,1,32,eth1
netdev=irq=21,io=0x2800,name=eth1

We have also tried to use "nameif" as a second approach, unfortunately
nameif seems to be limited to only having the capability to change any
logical Ethernet device name other than eth0.

We've even attempted use of the "pci=" commands with hopes of reversing
the PCI search order, and forced bios values, again without success.

If anyone has any suggestions or insight on how to work with netdev and
the e1000 properly it would be greatly appreciated! 

Thanks very much
-Alex

Alex.upton@inetats.com



*****************************************************************
<<<Disclaimer>>>

In compliance with applicable rules and regulations, Instinet
reviews and archives incoming and outgoing email communications,
copies of which may be produced at the request of regulators.
This message is intended only for the personal and confidential
use of the recipients named above.  If the reader of this email
is not the intended recipient, you have received this email in
error and any review, dissemination, distribution or copying is
strictly prohibited. If you have received this email in error,
please notify the sender immediately by return email and
permanently delete the copy you received.  

Instinet accepts no liability for any content contained in the
email, or any errors or omissions arising as a result of email
transmission. Any opinions contained in this email constitute
the sender's best judgment at this time and are subject to change
without notice.   Instinet does not make recommendations of a
particular security and the information contained in this email
should not be considered as a recommendation, an offer or a
solicitation of an offer to buy and sell securities.

*****************************************************************

