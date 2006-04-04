Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWDDXyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWDDXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWDDXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 19:54:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:32612 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750943AbWDDXyP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 19:54:15 -0400
X-IronPort-AV: i="4.03,165,1141632000"; 
   d="scan'208"; a="19375418:sNHT39090807"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] MPBL0010 driver sysfs permissions wide open
Date: Tue, 4 Apr 2006 16:54:08 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D56B3A7@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] MPBL0010 driver sysfs permissions wide open
thread-index: AcZYHRqO/Pk22Fr/Ty6PlMN0C0DmfgAJaZGg
From: "Gross, Mark" <mark.gross@intel.com>
To: "Mark Bellon" <mbellon@mvista.com>, <linux-kernel@vger.kernel.org>,
       <sebastien.bouchard@ca.kontron.com>
X-OriginalArrivalTime: 04 Apr 2006 23:54:13.0393 (UTC) FILETIME=[1325B810:01C65843]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK.

This looks good to me.  

The use case for this driver is to configure the fail over behavior of
the clock hardware.  That should be done by the more privileged users.

Thanks,

--mgross

>-----Original Message-----
>From: Mark Bellon [mailto:mbellon@mvista.com]
>Sent: Tuesday, April 04, 2006 12:32 PM
>To: linux-kernel@vger.kernel.org; Gross, Mark;
>sebastien.bouchard@ca.kontron.com
>Subject: [PATCH] MPBL0010 driver sysfs permissions wide open
>
>The MPBL0010 Telco clock driver (drivers/char/tlclk.c) uses 0222
(anyone
>can write) permissions on its writable sysfs entries. IMHO this is a
bit
>too wide open for proper security. The patch (against 2.6.16.1) alters
>the permissions to 0220 (owner and group can write).
>
>Signed-off-by: Mark Bellon <mbellon@mvista.com>
>
>mark
>
