Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTKGDBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 22:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTKGDBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 22:01:00 -0500
Received: from fmr06.intel.com ([134.134.136.7]:4758 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262679AbTKGDA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 22:00:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: RE: Why size of sockaddr smaller than size of sockaddr_in6?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 7 Nov 2003 11:00:55 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E011959C7@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why size of sockaddr smaller than size of sockaddr_in6?
Thread-Index: AcOk1icmXB2zJzUySCOOs2BACunFyAABLCnw
From: "Zheng, Jeff" <jeff.zheng@intel.com>
To: "YOSHIFUJI Hideaki / ????" <yoshfuji@linux-ipv6.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Nov 2003 03:00:55.0233 (UTC) FILETIME=[5C72DB10:01C3A4DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hideaki YOSHIFUJI,

Thanks for your reply. 

Is sockaddr_storage part of IPv6? I mean, does sockaddr_storage exist in a system that does not have IPv6? In such system if I use sockaddr_in6, the compile will be failed because there is no sockaddr_in6 structure. 

> Thanks
> Jeff                        Jeff.Zheng@intel.com
> BTW, I speak for myself, not for Intel Corp.


-----Original Message-----
From: Hideaki YOSHIFUJI [mailto:yoshfuji@cerberus.hongo.wide.ad.jp]On Behalf Of yoshfuji@linux-ipv6.org
Sent: Friday, November 07, 2003 10:24 AM
To: Zheng, Jeff
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why size of sockaddr smaller than size of sockaddr_in6?


Hello.

In article <37FBBA5F3A361C41AB7CE44558C3448E07EC27@pdsmsx403.ccr.corp.intel.com> (at Fri, 7 Nov 2003 10:04:05 +0800), "Zheng, Jeff" <jeff.zheng@intel.com> says:

> I thought that sockaddr should hold sockaddr_in sockaddr_in6 and any other socket address (or at least sockaddr_in6). 

No, we do not change sockaddr{}.
use sockaddr_storage{} for that purpose.
Please read RFC 3493.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
