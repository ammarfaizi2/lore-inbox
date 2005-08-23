Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVHWSDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVHWSDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVHWSDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:03:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13039 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932267AbVHWSDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:03:20 -0400
Subject: [Hugetlb x86] Small hugetlb arch updates for i386 and x86_64
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Date: Tue, 23 Aug 2005 12:57:46 -0500
Message-Id: <1124819866.4415.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.  The following 3 patches update the i386 and x86_64 hugetlb
arch code to bring it closer to the other architectures.  The first
patch adds a pte_huge() macro.  The second patch moves the "stale pte"
check into huge_pte_alloc() which seems more appropriate to me.  The
third patch checks for p?d_present() for each step in huge_pte_offset().

Barring any new objections, could we take these for a spin in -mm?

(Actual patches to follow)

