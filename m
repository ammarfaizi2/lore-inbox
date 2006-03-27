Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWC0XvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWC0XvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWC0XvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:51:20 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:16824 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932071AbWC0XvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:51:19 -0500
X-IronPort-AV: i="4.03,136,1141632000"; 
   d="scan'208"; a="420425095:sNHT32659568"
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com> <442848EF.4000407@ichips.intel.com>
	<adar74n5wbn.fsf@cisco.com> <44287853.5020804@ichips.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 27 Mar 2006 15:51:17 -0800
In-Reply-To: <44287853.5020804@ichips.intel.com> (Sean Hefty's message of "Mon, 27 Mar 2006 15:42:11 -0800")
Message-ID: <adahd5je9ai.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Mar 2006 23:51:17.0866 (UTC) FILETIME=[57386CA0:01C651F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sean> I'm actually testing a patch set now that moves rdma_wq
    Sean> internal to ib_addr, and gives the RDMA CM its own WQ.

OK, that's better still.

BTW ib_local_sa also uses rdma_wq ... it might be worth fixing that,
because it actually makes ib_local_sa depend on CONFIG_NET right now
(since ib_addr can't build without CONFIG_NET).

Not that anyone is building kernels without CONFIG_NET...

 - R.
