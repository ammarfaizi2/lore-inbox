Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTKGCEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 21:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTKGCEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 21:04:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:16558 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261309AbTKGCEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 21:04:10 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: Why size of sockaddr smaller than size of sockaddr_in6?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 7 Nov 2003 10:04:05 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E07EC27@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why size of sockaddr smaller than size of sockaddr_in6?
Thread-Index: AcOk05/H/bWYyrjFQe6OZ7yelYCl4A==
From: "Zheng, Jeff" <jeff.zheng@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Nov 2003 02:04:05.0194 (UTC) FILETIME=[6BE832A0:01C3A4D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought that sockaddr should hold sockaddr_in sockaddr_in6 and any other socket address (or at least sockaddr_in6). 
Current definition:
struct sockaddr
  {
    __SOCKADDR_COMMON (sa_);    /* Common data: address family and length.  */
    char sa_data[14];           /* Address data.  */
  };

Can be:
struct sockaddr
  {
    __SOCKADDR_COMMON (sa_);    /* Common data: address family and length.  */
    char sa_data[28];           /* Address data.  */
  };

Is there any reason not to hold sockaddr_in6 in sockaddr?

Please CC the answers/comments posted to the list in response to my posting to me. 


> Thanks
> Jeff                        Jeff.Zheng@intel.com
> BTW, I speak for myself, not for Intel Corp.
> 
