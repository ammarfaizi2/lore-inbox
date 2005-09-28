Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVI1VlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVI1VlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVI1VlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:41:13 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:25612 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750909AbVI1VlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:41:12 -0400
Date: Wed, 28 Sep 2005 14:40:47 -0700
Message-Id: <200509282140.j8SLelHR032216@zach-dev.vmware.com>
Subject: [PATCH 0/3] GDT alignment fixes
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 28 Sep 2005 21:41:11.0781 (UTC) FILETIME=[58136150:01C5C475]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three cleanup / fixes for CPU GDT alignment.  First comes from Andrew Morton,
PnP BIOS driver was broken during build.  I tested and fixed the PnP BIOS
code for SMP kernels, and third comes a fix for hotplug.

I included Andrew's initial fix for the benefit of those who didn't get it.

Testing: 4-way SMP boot/halt loops with APM and PnP compatible BIOS against
2.6.14-rc2.

Zachary Amsden <zach@vmware.com>
