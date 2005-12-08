Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVLHWYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVLHWYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVLHWYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:24:52 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:2601 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932358AbVLHWYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:24:51 -0500
X-IronPort-AV: i="3.99,232,1131350400"; 
   d="scan'208"; a="375861452:sNHT1872012770"
To: Kumar Gala <galak@gate.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Grover <andrew.grover@intel.com>,
       <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <john.ronciak@intel.com>, <christopher.leech@intel.com>
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.44.0512081606060.24134-100000@gate.crashing.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 08 Dec 2005 14:23:40 -0800
In-Reply-To: <Pine.LNX.4.44.0512081606060.24134-100000@gate.crashing.org> (Kumar
 Gala's message of "Thu, 8 Dec 2005 16:13:52 -0600 (CST)")
Message-ID: <ada4q5jz0r7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 08 Dec 2005 22:23:41.0220 (UTC) FILETIME=[0AFD2640:01C5FC46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Kumar> I'm actually searching for any examples of drivers that
    Kumar> deal with the issues related to DMA'ng directly two and
    Kumar> from user space memory.

It's not quite the same story as what you're doing with DMA engines
inside the CPU, but you could look at drivers/infiniband, particularly
drivers/infiniband/core/uverbs_mem.c.  That handles pinning and
getting DMA addresses for user memory that will be used as a DMA
target in the future.

 - R.
