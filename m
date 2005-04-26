Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVDZPCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVDZPCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDZPCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:02:03 -0400
Received: from mxsf28.cluster1.charter.net ([209.225.28.228]:9370 "EHLO
	mxsf28.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261555AbVDZPB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:01:56 -0400
X-Ironport-AV: i="3.92,132,1112587200"; 
   d="scan'208"; a="1061450198:sNHT13562076"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17006.22498.394169.98413@smtp.charter.net>
Date: Tue, 26 Apr 2005 11:01:54 -0400
From: "John Stoffel" <john@stoffel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
In-Reply-To: <20050426143247.GF10833@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	<OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
	<20050426134629.GU16169@viasys.com>
	<20050426141426.GC10833@mail.shareable.org>
	<426E4EBD.6070104@oktetlabs.ru>
	<20050426143247.GF10833@mail.shareable.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:

Jamie> No.  A transaction means that _all_ processes will see the
Jamie> whole transaction or not.

This is really hard.  How do you handle the case where process X
starts a transaction modifies files a, b & c, but process Y has file b
open for writing, and never lets it go?  Or the file gets unlinked?  

Jamie> For example, you can use transactions for distro package
Jamie> management: a whole update of a package would be a single
Jamie> transaction, so that at no time does any program see an
Jamie> inconsistent set of files.  See why _every_ process in the
Jamie> system must have the same view?

What about programs that are already open and running?  

It might be doable in some sense, but I can see that details are
really hard to get right.  Esp without breaking existing Unix
semantics.  

But then again, I could be smoking something good (or bad :-) here, so
take what I say with a grain of salt.

John
