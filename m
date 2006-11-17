Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755887AbWKQUhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbWKQUhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755883AbWKQUhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:37:08 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:27561 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1755882AbWKQUhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:37:05 -0500
To: Steve Wise <swise@opengridcomputing.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH  11/13] Core Resource Allocation
X-Message-Flag: Warning: May contain useful information
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	<20061116035923.22635.5397.stgit@dell3.ogc.int>
	<adaslgim2tt.fsf@cisco.com> <1163784311.8457.44.camel@stevo-desktop>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 17 Nov 2006 12:37:03 -0800
In-Reply-To: <1163784311.8457.44.camel@stevo-desktop> (Steve Wise's message of "Fri, 17 Nov 2006 11:25:11 -0600")
Message-ID: <ada4psxn72o.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Nov 2006 20:37:04.0220 (UTC) FILETIME=[242E69C0:01C70A88]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I think we can use random32() or get_random_bytes().  I need to
 > re-review how this algorithm works.  Its randomizing the stag IDs so
 > they are not predictable.

I assume based on the algorithm you have now that they don't need to
be cryptographically unpredictable.  So random32() would probably be
the best thing to do (get_random_bytes() should be used sparingly,
since it depletes the kernel entropy pool).

 - R.
