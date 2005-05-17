Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVEQFhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVEQFhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVEQFhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:37:09 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:7809 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261154AbVEQFhB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 01:37:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFD] What error should FS return when I/O failure occurs?
Date: Mon, 16 May 2005 22:36:54 -0700
Message-ID: <75D9B5F4E50C8B4BB27622BD06C2B82B2264F6@xmb-sjc-235.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFD] What error should FS return when I/O failure occurs?
Thread-Index: AcVanZSiAjaRyLPYTseJfnO1/U5eHQABCvZA
From: "Hua Zhong \(hzhong\)" <hzhong@cisco.com>
To: "fs" <fs@ercist.iscas.ac.cn>, <coywolf@lovecn.org>
Cc: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Kenichi Okuyama" <okuyama@intellilink.co.jp>
X-OriginalArrivalTime: 17 May 2005 05:36:55.0403 (UTC) FILETIME=[6FA233B0:01C55AA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What you said is based on the FS implementor's perspective.
> But from user's perspective, they open a file with O_RDWR, get a
> success, then write returns EROFS?
> Besides, EXT3 ALWAYS return EROFS for the 1st and 2nd case, even
> you specify errors=continue, things are still the same.

Which version of kernel you are using?

It was probably the case in kernel before 2.4.20. The old ext3 had a
problem that it ignored IO error at journal commit time. I submitted a
patch to fix that around the time of 2.4.20. 2.6 should be fine too,
unless someone else broke it again.

Hua
