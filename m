Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVEaRtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVEaRtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVEaRt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:49:28 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:56362 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262037AbVEaRtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:49:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROBLEM: Kernel Crash - Machine Exception Interpretation?
Date: Tue, 31 May 2005 10:49:09 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B004FAE239@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Kernel Crash - Machine Exception Interpretation?
thread-index: AcVjk4B7Y5TXbI9tToyo1/Lgk9yXJQCdKF0w
From: "Allen Martin" <AMartin@nvidia.com>
To: "John W. M. Stevens" <john@betelgeuse.us>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 May 2005 17:49:09.0639 (UTC) FILETIME=[0C431970:01C56609]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	May 27 21:42:06 morningstar kernel: CPU 1: Machine 
> Check Exception: 0000000000000004
> 	May 27 21:42:07 morningstar kernel: Bank 0: e200000000000175

That's a timeout on a L1 data cache evict, probably related to the
following:

> 	May 27 21:42:07 morningstar kernel: Bank 2: 
> b60020000000011a at 000000000bf16280May 27 21:42:07 

That's an uncorrectable (multibit) ECC error on a L2 cache read.

I would look for BIOS updates or replace the RAM.  You should probably
see failures if you run memtest86 also.

