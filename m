Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTFTTbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTFTTbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 15:31:40 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:16589 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264503AbTFTTbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 15:31:39 -0400
Date: Fri, 20 Jun 2003 21:45:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
Message-ID: <20030620194517.GA22732@wohnheim.fh-wedel.de>
References: <20030620185915.GD28711@wohnheim.fh-wedel.de> <20030620190957.GA19988@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030620190957.GA19988@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 June 2003 15:09:57 -0400, Jeff Garzik wrote:
> 
> The big question is whether the bzip2 better compression is actually
> useful in a kernel context?  Patches to do bzip2 for initrd, for
> example, have been around for ages:
> 
> 	http://gtf.org/garzik/kernel/files/initrd-bzip2-2.2.13-2.patch.gz
> 
> But the compression and decompression overhead is _much_ larger
> than gzip.  It was so huge for maximal compression that dialing back
> compression reaching a point of diminishing returns rather quickly,
> when compared to gzip memory usage and compression.
> 
> I talked a bit with the bzip2 author a while ago about memory usage.
> He eventually added the capability to only require small blocks
> for decompression (64K IIRC?), but there was a significant loss in
> compression factor.

You are puzzling me a bit.  What exactly do you consider to be the
overhead?  Code size?  Memory consumption?  CPU time?

When it comes to compression, the combination of compressed data and
decompression code should be larger than uncompressed data, everything
else is secondary.  The secondary stuff might still affect some users,
but it is not a general problem.

> So... even in 2003, I really don't know of many (any?) tasks which
> would benefit from bzip2, considering the additional memory and
> cpu overhead.

That overhead will become less important with time.  And if we will
merge bzlib anyway, we may as well do it today.

But I do agree with you that some choices made by the maintainer were
rather stupid.  And one of them is the reason for this thread and
appears to be the whole point behind your argument.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown
