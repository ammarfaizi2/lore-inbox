Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVEJVri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVEJVri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVEJVrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:47:37 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:22429 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S261831AbVEJVrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:47:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]: Don't force O_LARGEFILE for 32 bit processes on ia64 - 2.6.12-rc3
Date: Tue, 10 May 2005 23:45:59 +0200
Message-ID: <2C83850C013A2540861D03054B478C0606112A22@hasmsx403.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: Don't force O_LARGEFILE for 32 bit processes on ia64 - 2.6.12-rc3
Thread-Index: AcVVkR/VizFsjk51RMaRXiiLnqOy8wAFvBkA
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "David S. Miller" <davem@davemloft.net>, <anton@samba.org>
Cc: <yoav_zach@yahoo.com>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Zach, Yoav" <yoav.zach@intel.com>
X-OriginalArrivalTime: 10 May 2005 21:46:00.0229 (UTC) FILETIME=[A7C24D50:01C555A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: David S. Miller [mailto:davem@davemloft.net] 
>Sent: Tuesday, May 10, 2005 21:47
>To: anton@samba.org
>Cc: yoav_zach@yahoo.com; torvalds@osdl.org; 
>linux-kernel@vger.kernel.org; Zach, Yoav
>Subject: Re: [PATCH]: Don't force O_LARGEFILE for 32 bit 
>processes on ia64 - 2.6.12-rc3
>
>
>I really think these "emulators" should execute the compat
>syscalls and not the native 64-bit ones.  That is where
>all of these problems come from.
>

Compat syscalls are not accessible to userland. Changing that
will be a major change, with impacts on security and all. I'm
not sure it worth the effort.

>And yes, as Anton stated, you need to audit every platform's
>compat layer to make sure this PER_LINUX32 thing doesn't break
>anything for them.
>

The patch has no impact at all on any arch other than ia64.

Thanks,
Yoav.

