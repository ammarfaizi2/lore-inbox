Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWEOXDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWEOXDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWEOXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:03:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:35718 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750729AbWEOXDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:03:48 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 May 2006 09:03:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17513.2236.102102.929378@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
In-Reply-To: message from Andrew Morton on Monday May 15
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
	<17509.22160.118149.49714@cse.unsw.edu.au>
	<20060512235934.4f609019.akpm@osdl.org>
	<17511.51907.537657.656420@cse.unsw.edu.au>
	<20060515140457.18991c2e.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 15, akpm@osdl.org wrote:
> 
> Ho hum, I give up.

Thankyou :-)  I found our debate very valuable - it helped me clarify
my understanding of some areas of linux filesystem semantics (and as I
am trying to write a filesystem in my 'spare time', that will turn out
to be very useful).  It also revealed some problems in the code!

>                     I don't think, in practice, this code fixes any
> demonstrable bug though.

I thought it was our job to kill the bugs *before* they were
demonstrated :-)

I'm still convinced that the previous code could lead to deadlocks or
worse under sufficiently sustained high memory pressure and fs
activity.

I'll send a patch shortly that fixes the known problems and
awkwardnesses in the new code.

Thanks again,
NeilBrown
