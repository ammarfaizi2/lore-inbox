Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266554AbUG0SxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUG0SxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUG0Swa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:52:30 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:38930 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S266567AbUG0SqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:46:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.8-rc2] sata_nv.c
Date: Tue, 27 Jul 2004 11:45:19 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F95F4@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8-rc2] sata_nv.c
Thread-Index: AcRz/MaxbSqU1JC0Q/q9Hf5cug5RxgADMyfQ
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2004 18:46:01.0987 (UTC) FILETIME=[F6F31530:01C47409]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Please fix and resubmit:
> 4) [leak] driver appears to be missing a ->host_free hook, to 
> free your 
> nv_host_t structure.
> 
> +       host = kmalloc(sizeof(nv_host_t), GFP_KERNEL);

I register a host_stop routine, nv_host_stop(), that frees the host.  Is
this not the correct way to free the nv_host?
