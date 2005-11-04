Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVKDXQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVKDXQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVKDXQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:16:00 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:740 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750987AbVKDXP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:15:59 -0500
Date: Fri, 4 Nov 2005 15:15:52 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: [PATCH 0/4] Memory Add Fixes for ppc64
Message-ID: <20051104231552.GA25545@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When memory add was merged into mainline in 2.6.14, there were
various bits and pieces missing that prevent it from working on
ppc64.  The following patches are against 2.6.14-git7 and address
all but one of the know issues.

1) Create hptes for new sections
2) Clear page count before freeing new pages
3) Kludge to add new memory to node 0
4) Ensure probe file is created for memory add via sysfs

-- 
Mike
