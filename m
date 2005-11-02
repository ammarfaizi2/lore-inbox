Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965302AbVKBWEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbVKBWEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbVKBWEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:04:49 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:51311 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965296AbVKBWEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:04:48 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH/RFC v2] IB: Add SCSI RDMA Protocol (SRP) initiator
X-Message-Flag: Warning: May contain useful information
References: <52r79y91jz.fsf_-_@cisco.com>
	<20051102220358.GA27132@mellanox.co.il>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 02 Nov 2005 14:04:41 -0800
In-Reply-To: <20051102220358.GA27132@mellanox.co.il> (Michael S. Tsirkin's
 message of "Thu, 3 Nov 2005 00:03:58 +0200")
Message-ID: <52mzkm905i.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 02 Nov 2005 22:04:43.0245 (UTC) FILETIME=[6DD4F1D0:01C5DFF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> This seems to leak sizeof *attr bytes if
    Michael> ib_find_cached_pkey returns an error.

Good catch.  It actually seems to leak attr unconditionally...
I'll fix it up now.

 - R.
