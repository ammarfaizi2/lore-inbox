Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVEQGAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVEQGAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVEQGAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:00:41 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:6811 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261173AbVEQGAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:00:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFD] What error should FS return when I/O failure occurs?
Date: Mon, 16 May 2005 23:00:24 -0700
Message-ID: <75D9B5F4E50C8B4BB27622BD06C2B82B2264F7@xmb-sjc-235.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFD] What error should FS return when I/O failure occurs?
Thread-Index: AcVao8z1uauUWlgoRsCTRsJBYjpMogAAaBMg
From: "Hua Zhong \(hzhong\)" <hzhong@cisco.com>
To: "fs" <fs@ercist.iscas.ac.cn>
Cc: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Kenichi Okuyama" <okuyama@intellilink.co.jp>
X-OriginalArrivalTime: 17 May 2005 06:00:25.0441 (UTC) FILETIME=[B814ED10:01C55AA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thing is the EIO almost always happens at background so there is no
way to return it to the user space. If you want to see EIO, do fsync
explicitly.

> > Which version of kernel you are using?
> My test environment is based on 2.6.11 kernel
> > It was probably the case in kernel before 2.4.20. The old ext3 had a
> > problem that it ignored IO error at journal commit time. I 
> submitted a
> > patch to fix that around the time of 2.4.20. 2.6 should be fine too,
> > unless someone else broke it again.
> > 
> > Hua
> 
