Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753492AbWKFUVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbWKFUVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbWKFUVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:21:54 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:51849 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1753492AbWKFUVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:21:53 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAADooT0WrR7PDh2dsb2JhbACMSQEBAQgOKg
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="448365265:sNHT26637512"
To: Ingo Molnar <mingo@elte.hu>
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: locking hierarchy based on lockdep
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
	<20061106200529.GA15370@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Nov 2006 12:21:50 -0800
In-Reply-To: <20061106200529.GA15370@elte.hu> (Ingo Molnar's message of "Mon, 6 Nov 2006 21:05:29 +0100")
Message-ID: <adapsc0l40x.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Nov 2006 20:21:51.0056 (UTC) FILETIME=[31596500:01C701E1]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > i like your idea of using lockdep to document locking hierarchies.

Yes, it's definitely a cool idea.  I think the current implementation
is not that useful, since it jams all the unrelated kernel locks into
a single ordered list, when in fact many locks simply have no ordering
relationship at all because they're never both taken.  This makes the
list hard to read and in fact loses the information of which locks
have been taken together.

 - R.
