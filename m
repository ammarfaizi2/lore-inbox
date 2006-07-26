Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWGZPP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWGZPP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWGZPP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:15:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:52373 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750750AbWGZPP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:15:27 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="104944196:sNHT30015692"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: A better interface, perhaps: a timed signal flag
Date: Wed, 26 Jul 2006 11:15:16 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601124E60@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: A better interface, perhaps: a timed signal flag
Thread-Index: AcawwonOoyefTB6FQ9y4QC8K3QRiGgAAGZQw
From: "Brown, Len" <len.brown@intel.com>
To: "Theodore Tso" <tytso@mit.edu>, "Neil Horman" <nhorman@tuxdriver.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Segher Boessenkool" <segher@kernel.crashing.org>,
       "Dave Airlie" <airlied@gmail.com>, <linux-kernel@vger.kernel.org>,
       <a.zummo@towertech.it>, <jg@freedesktop.org>
X-OriginalArrivalTime: 26 Jul 2006 15:15:18.0533 (UTC) FILETIME=[4E00DB50:01C6B0C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>if the application doesn't need to
>know exactly how many microseconds have gone by, but just whether or
>not 150us has ellapsed, why calculate the necessary time?  (Especially
>if it requires using some ACPI interface...)

Yes, ACPI is involved in the boot-time enumeration of various timers
and counters.  But at run-time; the use of any and all of them
(including the PM_TIMER supplied by ACPI hardware itself) could/should
appear generic to kernel users, who should not have to directly call
any routine with an "acpi" in it.

I believe that this is true today, and can/should stay true.

-Len
