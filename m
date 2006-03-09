Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWCIXdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWCIXdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWCIXdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:33:50 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:16449 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932137AbWCIXdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:33:47 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="260909189:sNHT37380308"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:33:45 -0800
In-Reply-To: <71644dd19420ddb07a75.1141922823@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:03 -0800")
Message-ID: <adazmjzdwh2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:33:46.0713 (UTC) FILETIME=[E93FB490:01C643D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +		yield();	/* don't hog the cpu */

You probably don't want to do this -- yield() means "put me at the
tail of the runqueue."  I think cond_resched() is more likely what you
want.

 > +#endif
 > +/* END_NOSHIP_TO_OPENIB */

uhh... and I don't see an #if to match that #endif.

 - R.
