Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWEPCQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWEPCQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWEPCQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:16:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20132 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751062AbWEPCQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:16:40 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 May 2006 12:16:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17513.13808.915295.711470@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       reuben-lkml@reub.net
Subject: Re: [PATCH 001 of 3] md: Change md/bitmap file handling to use bmap
 to file blocks-fix
In-Reply-To: message from Andrew Morton on Monday May 15
References: <20060516111036.2649.patches@notabene>
	<1060516011302.2711@suse.de>
	<20060515185440.0989a805.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 15, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> >  +		do_sync_file_range(file, 0, LLONG_MAX,
> >  +				   SYNC_FILE_RANGE_WRITE |
> >  +				   SYNC_FILE_RANGE_WAIT_AFTER);
> 
> That needs a SYNC_FILE_RANGE_WAIT_BEFORE too.  Otherwise any dirty,
> under-writeback pages will remain dirty.  I'll make that change.

Ahhh.. yes... that makes sense!  Thanks :-)

NeilBrown
