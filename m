Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTFTTwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 15:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTFTTwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 15:52:13 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:41683 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264542AbTFTTwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 15:52:12 -0400
Date: Fri, 20 Jun 2003 22:05:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
Message-ID: <20030620200554.GC22732@wohnheim.fh-wedel.de>
References: <20030620194517.GA22732@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0306201247560.28021-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0306201247560.28021-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 June 2003 12:48:51 -0700, David Lang wrote:
> 
> he is saying that the memory and CPU requirements to do the bzip
> uncompression are so much larger then what is nessasary to do the gzip
> uncompression that the small amount of space saved is almost never worth
> the cost.

Which is why kernel images usually come as .bz2 today. ;)

Read my first posting, read the source (grep for BZMALLOC, there are
just a few).  It is impossible in it's current state to use less than
roughly 1MB of memory, even though the algorithm doesn't give that
restriction at all.  Drop that down to 280k, the current zlib value
and you won't see a difference in compression ratios for jffs2 at
least.

This might boil down to bzlib merge 100% (minus testing and sending
patches) done and <nifty_name>, which is based on bzlib, just started.

Comments?

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
