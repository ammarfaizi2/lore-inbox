Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWFGJX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFGJX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWFGJX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:23:26 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:48706 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S932085AbWFGJXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:23:25 -0400
Subject: pci_map_single() on IA64
From: Adhiraj <adhiraj@linsyssoft.com>
To: linux-kernel@vger.kernel.org
Cc: adhiraj@linsyssoft.com
Content-Type: text/plain
Date: Wed, 07 Jun 2006 14:34:09 +0530
Message-Id: <1149671049.3499.27.camel@triumph>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

How is it possible that on an IA64 machine, the address returned by
pci_map_single() is above 4G (32 bits) when I have only 2G of physical
memory?

The DMA mask is set to 64 bits (using pci_set_dma_mask()). When I change
it to 32 bit DMA mask, the problem goes away.

This problem does not appear on i388/x86_64 machines.

Thanks,
Adhiraj.

