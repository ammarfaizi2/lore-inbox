Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUCLXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbUCLXWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:22:09 -0500
Received: from fmr06.intel.com ([134.134.136.7]:11206 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263031AbUCLXV6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:21:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH 2.6-BK] Fix stray pointer in e100
Date: Fri, 12 Mar 2004 15:21:22 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF5E5F@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6-BK] Fix stray pointer in e100
Thread-Index: AcQIemZyME4wCCBJRQqNyaTMI122iwADq+1A
From: "Feldman, Scott" <scott.feldman@intel.com>
To: <dsaxena@plexity.net>, <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Mar 2004 23:21:23.0073 (UTC) FILETIME=[BBB0FF10:01C40888]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> e100_alloc_cbs() allocates the cb's but does not set cb->skb 
> = NULL which means that the following check in 
> e100_tx_clean() will execute even though cb->skb is not 
> really a valid pointer an we OOPs:

Thanks Deepak.  I found one other place where we need to set
cb->skb=NULL.  Patch sent to Jeff upstream.

-scott
