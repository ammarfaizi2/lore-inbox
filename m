Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVKBGML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVKBGML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKBGML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:12:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932313AbVKBGMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:12:10 -0500
Date: Wed, 2 Nov 2005 16:11:34 +1100
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, mbligh@mbligh.org,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051102161134.25f3b85d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0511011358520.14884@skynet>
References: <20051030235440.6938a0e9.akpm@osdl.org>
	<27700000.1130769270@[10.10.2.4]>
	<4366A8D1.7020507@yahoo.com.au>
	<Pine.LNX.4.58.0510312333240.29390@skynet>
	<4366C559.5090504@yahoo.com.au>
	<Pine.LNX.4.58.0511010137020.29390@skynet>
	<4366D469.2010202@yahoo.com.au>
	<Pine.LNX.4.58.0511011014060.14884@skynet>
	<20051101135651.GA8502@elte.hu>
	<Pine.LNX.4.58.0511011358520.14884@skynet>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>
> As GFP_ATOMIC and GFP_NOFS cannot do
>  any reclaim work themselves

Both GFP_NOFS and GFP_NOIO can indeed perform direct reclaim.   All
we require is __GFP_WAIT.
