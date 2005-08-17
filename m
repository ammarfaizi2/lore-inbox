Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVHQLdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVHQLdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVHQLdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:33:04 -0400
Received: from [202.125.80.34] ([202.125.80.34]:55093 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1751087AbVHQLdD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:33:03 -0400
Content-class: urn:content-classes:message
Subject: get_start_sect() NOTE HOW?...
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 17 Aug 2005 16:56:54 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B37EE@mail.esn.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: get_start_sect() NOTE HOW?...
Thread-Index: AcWjHpHYV62+yhHhRLy47fQw2YdjPQ==
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear all,

Sorry for the MOST silly question in this list.
I am mailing it here as this related to kernel.

I am writing a block driver for MMC interface.
In the HDIO_GETGEO ioctl, the hd_geometry structure is filled.
I have doubt updating the 'start' field of the hd_geometry structure.

I am doing the following to get it.
geo.start = get_start_sect(inode->i_bdev);
What is the start expected to point to? Is it the start of FS?

When I looked at the get_start_sect(), I found it is trying to pull out
the data from the "bdev->bd_part->start_sect".

Do I need to handle any thing before this to get the proper start value.
Or Is it taken care in the upper layers?

Can you please explain if is it any way wrong if I hard-code start to
'0'?

Regards,
Mukund Jampala

