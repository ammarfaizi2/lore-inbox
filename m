Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWCUDQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWCUDQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 22:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWCUDQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 22:16:43 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:45392 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751471AbWCUDQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 22:16:42 -0500
X-IronPort-AV: i="4.03,112,1141632000"; 
   d="scan'208"; a="1786711061:sNHT27283302"
To: linux-kernel@vger.kernel.org
Subject: Re: nommu_map_sg: overflow with ata_piix?
X-Message-Flag: Warning: May contain useful information
References: <adawteoa9pc.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Mar 2006 19:16:37 -0800
In-Reply-To: <adawteoa9pc.fsf@cisco.com> (Roland Dreier's message of "Mon, 20 Mar 2006 17:05:35 -0800")
Message-ID: <adaoe00a3my.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2006 03:16:38.0248 (UTC) FILETIME=[DDD94680:01C64C95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff

Never mind, I'm (sort of) an idiot.  The kernel that complained like
that had CONFIG_GART_IOMMU=n -- I foolishly thought, "I have a Xeon,
which can't do GART IOMMU, so I don't need that option."  I didn't
realize that it also enables swiotlb.  Once I read the help text I was
OK.

 - R.
