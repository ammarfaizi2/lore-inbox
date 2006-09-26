Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWIZNuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWIZNuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWIZNuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:50:55 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:23935 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP
	id S1751493AbWIZNuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:50:54 -0400
Subject: __get_free_pages() on an ia64
From: Adhiraj <adhiraj@linsyssoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 26 Sep 2006 18:46:40 +0530
Message-Id: <1159276600.4407.11.camel@triumph>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I found a strange thing on ia64 platform. When I allocate pages using
__get_free_pages() with GFP_DMA, sometimes the physical addresses of
allocated pages fall beyond 4G.

I am working on a device driver where the device does not support
addresses above 4G and hence I have to implement bounce buffers. The
bounce buffer code works fine on other architectures. But since I get 
4G+ addresses on ia64, the code would not work. Any idea why should this
happen? And any workaround if I _NEED_ addresses below 4G. The machine
has 2G of physical memory.

The dma mask is set to 64 bits using pci_set_dma_mask().

Thanks in advance,
Adhiraj.


