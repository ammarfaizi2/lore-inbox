Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWGLTBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWGLTBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWGLTBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:01:40 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42664 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750819AbWGLTBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:01:39 -0400
X-IronPort-AV: i="4.06,236,1149490800"; 
   d="scan'208"; a="305287232:sNHT23430192"
To: Arjan van de Ven <arjan@infradead.org>
Cc: Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [openib-general] ipoib lockdep warning
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <ada7j2jzh5o.fsf@cisco.com>
	<1152686978.3217.14.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Jul 2006 12:01:37 -0700
Message-ID: <adasll6wstq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jul 2006 19:01:38.0900 (UTC) FILETIME=[9ABFE940:01C6A5E5]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > this does not have to be a false positive!
 > It is not legal to take ANY non-hardirq safe lock after having taken a
 > lock that's used in hardirq context.
 > (having said that the skb_queue_tail lock needs a  special treatment for
 > some real false positives; Linus merged that already)

 ...

 > Now this assumes your queue is shared with the networking stack,

Right, understood -- but ipoib has a private skb queue.  Which is why
I said it was a false positive.

Thanks,
  Roland
