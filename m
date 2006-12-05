Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755649AbWLEXtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649AbWLEXtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756548AbWLEXtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:49:16 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:11062 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbWLEXtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:49:15 -0500
X-IronPort-AV: i="4.09,501,1157353200"; 
   d="scan'208"; a="351508595:sNHT43264644"
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Fleming <afleming@freescale.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
X-Message-Flag: Warning: May contain useful information
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 05 Dec 2006 15:49:09 -0800
In-Reply-To: <20061205135753.9c3844f8.akpm@osdl.org> (Andrew Morton's message of "Tue, 5 Dec 2006 13:57:53 -0800")
Message-ID: <adairgpc39m.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Dec 2006 23:49:12.0431 (UTC) FILETIME=[F6F74FF0:01C718C7]
Authentication-Results: sj-dkim-7; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim7002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > But running flush_scheduled_work() from within dev_close() is a very
 > sensible thing to do, and dev_close is called under rtnl_lock().

I can't argue with that -- this has actually bitten me in the past.

Hmm, I'll try to understand why we need rtnl_lock() to cover dev_close...

 - R.
