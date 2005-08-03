Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVHCTOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVHCTOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVHCTOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:14:18 -0400
Received: from fmr20.intel.com ([134.134.136.19]:53141 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262427AbVHCTOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:14:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2.6.12.3] drivers/pci: recognize more ICH7 PCI/SATA chips
Date: Wed, 3 Aug 2005 12:13:56 -0700
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F504764874@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH 2.6.12.3] drivers/pci: recognize more ICH7 PCI/SATA chips
thread-index: AcWYX364SC6m4vCURu6KtBMiLVIQVA==
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: <nash@solace.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Aug 2005 19:13:58.0862 (UTC) FILETIME=[801CE6E0:01C5985F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not right.  0x27b8 is the ICH7 LPC controller DID, not a SATA
Controller DID.  The ICH7 IDE mode SATA controller DID's are 0x27c0 and
0x27c4 and they are already in the quirks.c file.

Jason Gaston


>Message: 124
>Date: Tue, 2 Aug 2005 14:34:41 -0400
>From: Nash <nash@solace.net>
>Subject: Re: [PATCH 2.6.12.3] drivers/pci: recognize more ICH7
>	PCI/SATA chips
>To: linux-kernel@vger.kernel.org
>Message-ID: <20050802183441.GD25843@quack.solace.net>
>Content-Type: text/plain; charset=us-ascii
>
>
>On Tue, Aug 02, 2005 at 02:28:42PM -0400, Nash wrote:
>> 
>> Updated pci/quirks.c to recognize additional ICH7 PCI/SATA controller
>> chips such as those integrated on the ASUS P5WD2 Premium motherboard.
>> 
>> Signed-off-by: Nash E Foster <nash@solace.net>
>
>Blergh, this is the correct ratch. How embarrassing.
>
>Index: linux-2.6.12.3/drivers/pci/quirks.c
>===================================================================
>--- linux-2.6.12.3/drivers/pci/quirks.c 2005-07-15 17:18:57.000000000
>-0400
>+++ linux/drivers/pci/quirks.c  2005-07-26 22:32:09.000000000 -0400
>@@ -1199,6 +1199,7 @@
>        case 0x2680:    /* ESB2 */
>                ich = 6;
>                break;
>+       case 0x27b8:
>        case 0x27c0:
>        case 0x27c4:
>                ich = 7;

