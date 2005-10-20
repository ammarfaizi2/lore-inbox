Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbVJTCpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbVJTCpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 22:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbVJTCpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 22:45:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:60300 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751702AbVJTCpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 22:45:09 -0400
Subject: Re: Question about buffer usage
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Dave Pifke <dave@birthdayalarm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4356D55D.5060303@birthdayalarm.com>
References: <4356C1B2.3070401@bebo.com>
	 <20051019154940.55f18786.akpm@osdl.org>
	 <4356D55D.5060303@birthdayalarm.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 21:45:06 -0500
Message-Id: <1129776306.10190.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 16:23 -0700, Dave Pifke wrote:
> Andrew Morton wrote:
> 
>  > It could be a JFS quirk - I don't know much about JFS.  It'd be 
> interesting
>  > to know if other filesystems behave in a similar manner.
> 
> I have two more machines on order, so perhaps I'll try a different 
> filesystem on them and report back if it makes a difference.
> 
>  > One thing you could do is to (re)mount the filesystems with `-o noatime'.
> 
> I probably should have mentioned that this is already the case.
> 
>  > That should release _some_ of the blockdev pagecache, but not a lot, I
>  > expect.  Maybe JFS is just metadata-intensive..
> 
> There appears to be a jfs-discussion mailing list on SourceForge; I'll 
> try asking there.

I answered this in jfs-discussion, but for curious on linux-kernel:

There was a pretty major memory leak in jfs in the 2.6.8 kernel.  This
one-line fix is in the 2.6.9 kernel.  I'm guessing that this would
explain the problem you are seeing.
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/tglx/history.git;a=commitdiff;h=fcc1fcc376bb1fe8ed7609b07931fc5bd774943a

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

