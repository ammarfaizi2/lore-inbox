Return-Path: <linux-kernel-owner+w=401wt.eu-S965087AbXATBQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbXATBQG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 20:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbXATBQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 20:16:06 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:1048 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965084AbXATBQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 20:16:02 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 2.6.20 0/2] ehca: fix yield and spinlock conflicts
Date: Fri, 19 Jan 2007 22:49:32 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701192249.33587.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland!
Here is patch set for ehca with the following bug fixes:
* Fix unproper use of yield within spinlock context
* Fix mismatched spin_unlock in irq handler
Thanks
Nam


 ehca_cq.c  |    5 ++++-
 ehca_irq.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
