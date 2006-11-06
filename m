Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753620AbWKFUiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbWKFUiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbWKFUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:38:04 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:41830 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1753620AbWKFUiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:38:01 -0500
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="86293665:sNHT46187199"
To: Jason Baron <jbaron@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: locking hierarchy based on lockdep
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
	<20061106200529.GA15370@elte.hu> <adapsc0l40x.fsf@cisco.com>
	<Pine.LNX.4.64.0611061519220.29750@dhcp83-20.boston.redhat.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Nov 2006 12:37:56 -0800
In-Reply-To: <Pine.LNX.4.64.0611061519220.29750@dhcp83-20.boston.redhat.com> (Jason Baron's message of "Mon, 6 Nov 2006 15:22:33 -0500 (EST)")
Message-ID: <ada8xiol3a3.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Nov 2006 20:37:56.0543 (UTC) FILETIME=[70D304F0:01C701E3]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > interesting...perhaps if we layered say the directory structure on the 
 > list too like by the top level kernel directories drivers, kernel, mm, 
 > net, etc. it might be more readable.

I'm not sure that you need to do something manual or ad hoc like that,
although it might be necessary in the end.  I'd be curious to see how
the list of locks partitions up if you just divide it up into groups
of locks that have some relationship.  I guess the question is, if you
draw the graph whose nodes are locks and whose edges connect locks
that are held together, how many connected pieces does that graph have?

 - R.
