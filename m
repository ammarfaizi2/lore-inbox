Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWGNAST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWGNAST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 20:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbWGNASS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 20:18:18 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:8521 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1161152AbWGNASS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 20:18:18 -0400
X-IronPort-AV: i="4.06,238,1149490800"; 
   d="scan'208"; a="434298942:sNHT34124276"
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org> <adau05ltsso.fsf@cisco.com>
	<20060713135446.5e2c6dd5.akpm@osdl.org> <adau05lrzdy.fsf@cisco.com>
	<1152824747.3024.92.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 13 Jul 2006 17:18:14 -0700
Message-ID: <adad5c9rqd5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Jul 2006 00:18:16.0269 (UTC) FILETIME=[007A1FD0:01C6A6DB]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arjan> it does get harder if this is needed for your IB device to
    Arjan> do more work, so that your swap device on your IB can take
    Arjan> more IO's to free up ram..

That's the classic problem, but it's more a matter of the consumer
using GFP_NOIO in the right places.

 - R.
