Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752070AbWFWVRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWFWVRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWFWVRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:17:06 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:61718 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1752073AbWFWVRF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:17:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add MCP65 support for sata_nv driver
Date: Fri, 23 Jun 2006 14:16:59 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00604CEB4@hqemmail02.nvidia.com>
In-Reply-To: <449B5AF2.9090104@garzik.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add MCP65 support for sata_nv driver
Thread-Index: AcaWciqyZcpTL1WSS8i41nXo0+vTuwAlyNeg
From: "Andrew Chew" <AChew@nvidia.com>
To: "Jeff Garzik" <jeff@garzik.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Jun 2006 21:17:00.0277 (UTC) FILETIME=[5D9E7250:01C6970A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do you want to remove the RAID PCI ID?  That was not mentioned in 
> the patch description at all.

Sorry.  NVIDIA's future SATA controllers are going to be AHCI (so for
0104 RAID mode, we want the ahci driver to pick up these controllers.
We don't want future chips (chips for which we didn't add the proper
device IDs yet into their respective drivers) to be picked up by sata_nv
anymore.

What's missing, I realize now, is the 0104 generic entry that should be
in the ahci driver.  I'll send along a separate patch for that.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
