Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUIEGo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUIEGo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUIEGo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:44:58 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:17893 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S266244AbUIEGo4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:44:56 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: force_sig_info
Date: Sun, 5 Sep 2004 08:44:44 +0200
Message-ID: <2C83850C013A2540861D03054B478C06048FFA9D@hasmsx403.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: force_sig_info
Thread-Index: AcSR4a9Fc0ZGQtD3THa7beEVkXJ5NwBLw3rg
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Yoav Zach" <yoav_zach@yahoo.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Sep 2004 06:44:46.0200 (UTC) FILETIME=[D5180780:01C49313]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Linus Torvalds [mailto:torvalds@osdl.org] 
>Sent: Friday, September 03, 2004 21:12
>To: Yoav Zach
>Cc: akpm@osdl.org; linux-kernel@vger.kernel.org; Zach, Yoav
>Subject: Re: force_sig_info
>
>

>
>Why are you blocking signals that you want to get? Sounds like 
>a bug in 
>your program.
>
>		Linus
>

It's a translator - it emulates the behavior of the translated
'process', which is the one that sets the signal mask. On the
other hand, it has its own logic, which requires handling of
certain HW exceptions. In 2.4, signals that were raised due to
HW exceptions could be handled by the translator regardless of
the mask that was set by the translated process. We lost this
ability in 2.6. It will be very good for our product, and I
believe any similar product where a native process emulates 
behavior of another process, if we could have this ability
back.

Thanks,
Yoav.

