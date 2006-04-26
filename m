Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWDZDYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWDZDYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWDZDYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:24:32 -0400
Received: from mga03.intel.com ([143.182.124.21]:53072 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751383AbWDZDYb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:24:31 -0400
X-IronPort-AV: i="4.04,155,1144047600"; 
   d="scan'208"; a="27839728:sNHT17627631"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Tue, 25 Apr 2006 20:24:28 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA97EF6@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZo2Y4PGJ42PvvNSRiovPJS7tL1TQAB0yIQ
From: "Gross, Mark" <mark.gross@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <minyard@acm.org>, <alan@lxorguk.ukuu.org.uk>,
       <bluesmoke-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 26 Apr 2006 03:24:30.0501 (UTC) FILETIME=[EE345D50:01C668E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Randy.Dunlap [mailto:rdunlap@xenotime.net]
>Sent: Tuesday, April 25, 2006 7:34 PM
>To: Gross, Mark
>Cc: minyard@acm.org; alan@lxorguk.ukuu.org.uk; bluesmoke-
>devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; Carbonari,
>Steven; Ong, Soo Keong; Wang, Zhenyu Z
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>On Tue, 25 Apr 2006 16:25:59 -0700 Gross, Mark wrote:
>
>>
>> How about printing nothing like it used too?
>>
>> See attached.
>>
>> Signed-off-by: Mark Gross
>
>Hi Mark,
>
>This small patch will need some cleaning up:
>
>1.  Signed-off-by: Mark Gross <mark.gross@intel.com>
>
>2.  Try not to use attachments.  If you must, then make the attachment
>	type be text instead of octet-stream.
>
>3.  No need to init to 0:
>+static int force_function_unhide = 0;
>
>4.  Typos:
>
>+	/* check to see if device 0 function 1 is enbaled if it isn't we
>                                                  enabled; it it isn't,
we
>+	 * assume the BIOS has reserved it for a reason and is expecting
>+	 * exclusive access, we take care to not violate that assumption
and
>                                          not to violate
>+	 * fail the probe. */
>
>5.  indentation, typos, and at least one trailing space:
>
>+	if (!force_function_unhide && !(stat8 & (1 << 5))) {
>+		printk(KERN_INFO "contact your bios vendor to see if the
"
>                                  Contact your BIOS
>+		"E752x error registers can be safely un-hidden\n");
>		^indent one more tab
>
>---

Thanks,
I'll get these tomorrow AM.

--mgross
