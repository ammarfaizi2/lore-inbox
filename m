Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWD1MGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWD1MGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWD1MGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:06:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:26047 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030366AbWD1MGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:06:38 -0400
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Subject: initcall warnings in 2.6.17
Date: Fri, 28 Apr 2006 14:06:34 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281406.34217.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still get

initcall at 0xffffffff807414c2: pci_iommu_init+0x0/0x501(): returned with error code -1
initcall at 0xffffffff80748b4d: init_autofs4_fs+0x0/0xc(): returned with error code -16
initcall at 0xffffffff803c7d5c: init_netconsole+0x0/0x6b(): returned with error code -22
initcall at 0xffffffff80249307: software_resume+0x0/0xcf(): returned with error code -2

I'm not sure it was that good an idea to enable this warning by default in 2.6.17.
It will be still in the release and probably generate some user queries.

Might be better to disable it for 2.6.17 again and only reenable for 2.6.18 after
some auditing?

-Andi
