Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752490AbWJ0V2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbWJ0V2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbWJ0V2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:28:36 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:46084 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1752487AbWJ0V2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:28:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] sata_nv ADMA/NCQ support for nForce4 (v7)
Date: Fri, 27 Oct 2006 14:28:14 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48D33E@hqemmail02.nvidia.com>
In-Reply-To: <454045F6.7000704@shaw.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] sata_nv ADMA/NCQ support for nForce4 (v7)
Thread-Index: Acb4vr6pa09/x+pKSC+5u8X5pdZg2gBT8M8w
From: "Allen Martin" <AMartin@nvidia.com>
To: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: <linux-ide@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, <pitt@segfault.info>
X-OriginalArrivalTime: 27 Oct 2006 21:28:15.0591 (UTC) FILETIME=[D02FAF70:01C6FA0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another update to this patch, now version 7. This greatly 
> simplifies the 
> interrupt handler and gets rid of some of the weird code 
> relating to the 
> notifier clear registers (as well as a potential uninitialized value 
> usage that was in version 6). There still seems to be the 
> need to do a 
> notifier clear in the interrupt handler even when the notifiers are 
> empty. I'm not sure why that is, it would be nice to get some 
> input from 
> NVIDIA or those with the hardware specs as to what writing values 
> (including zero values) to the notifier clear registers actually does.

You always have to write both notifiers even if one is 0, no interrupt
ack takes place until both are written. 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
