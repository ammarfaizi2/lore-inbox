Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbWILAwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWILAwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWILAwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:52:53 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:21919 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965221AbWILAww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:52:52 -0400
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="1853048401:sNHT32137328"
To: "Dan Williams" <dan.j.williams@intel.com>
Cc: "Jeff Garzik" <jeff@garzik.org>, neilb@suse.de, linux-raid@vger.kernel.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       christopher.leech@intel.com
Subject: Re: [PATCH 08/19] dmaengine: enable multiple clients and operations
X-Message-Flag: Warning: May contain useful information
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	<20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
	<4505F4D0.7010901@garzik.org>
	<e9c3a7c20609111714h1b88f8cbid99c567d7f3e997c@mail.gmail.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 11 Sep 2006 17:52:47 -0700
In-Reply-To: <e9c3a7c20609111714h1b88f8cbid99c567d7f3e997c@mail.gmail.com> (Dan Williams's message of "Mon, 11 Sep 2006 17:14:44 -0700")
Message-ID: <adairjt3nz4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Sep 2006 00:52:48.0720 (UTC) FILETIME=[C48A0D00:01C6D605]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> Are we really going to add a set of hooks for each DMA
    Jeff> engine whizbang feature?

    Dan> What's the alternative?  But, also see patch 9 "dmaengine:
    Dan> reduce backend address permutations" it relieves some of this
    Dan> pain.

I guess you can pass an opcode into a common "start operation" function.

With all the memcpy / xor / crypto / etc. hardware out there already,
we definitely have to get this interface right.

 - R.
