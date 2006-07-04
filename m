Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWGDRGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWGDRGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 13:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWGDRGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 13:06:50 -0400
Received: from mxl145v68.mxlogic.net ([208.65.145.68]:31968 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S932304AbWGDRGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 13:06:49 -0400
Date: Tue, 4 Jul 2006 19:52:34 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] [PATCH] mthca: initialize send and receive queue locks separately
Message-ID: <20060704165234.GA5935@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <44AA9999.3060308@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AA9999.3060308@oracle.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 04 Jul 2006 16:57:17.0546 (UTC) FILETIME=[E821A4A0:01C69F8A]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Zach Brown <zach.brown@oracle.com>:
> Is that just a side-effect of
> relying on mthca_wq_init() to reset the non-lock members?

Yes.


> If you're
> concerned about microoptimization it seems like this could be avoided.

This is off the fast path so I think Roland's idea was we should only care
about code size. But might be worth thinking this over, anyway. Thanks!

-- 
MST
