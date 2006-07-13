Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWGMPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWGMPmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWGMPmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:42:50 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:62074 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964786AbWGMPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:42:50 -0400
X-IronPort-AV: i="4.06,238,1149490800"; 
   d="scan'208"; a="1838196644:sNHT25046558"
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 13 Jul 2006 08:42:47 -0700
Message-ID: <adau05ltsso.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jul 2006 15:42:48.0251 (UTC) FILETIME=[FDF118B0:01C6A692]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Sigh.  It was always a mistake (of the kernel programming 101 type) to put
 > any locking at all in the idr code.  At some stage we need to weed it all
 > out and move it to callers.
 > 
 > Your fix is yet more fallout from that mistake.

Agreed.  Consider me on the hook to fix this up in a better way once
my life is a little saner.  Maybe I'll try to cook something up on the
plane ride to Ottawa.

Anyway you can punch me in the stomach if I don't have something in
time for 2.6.19.

 - R.
