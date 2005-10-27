Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVJ0Izf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVJ0Izf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVJ0Izf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:55:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20141 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965008AbVJ0Ize (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:55:34 -0400
Date: Thu, 27 Oct 2005 01:55:04 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rajesh.shah@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] export cpu_online_map
Message-Id: <20051027015504.5a20ed05.pj@sgi.com>
In-Reply-To: <20051026210803.07efba69.akpm@osdl.org>
References: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
	<20051026205038.26a1c333.pj@sgi.com>
	<20051026210803.07efba69.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> > Since bk no longer works for me, I have no idea how to access any
> > history prior to about 2.6.12-rc2.  Ugh.
> 
> There's still bkbits.net:
> 
> http://linux.bkbits.net:8080/linux-2.6/...

Ok - that helps.  Thanks.

There is also an hg (mercurial) web based Linux history at:

  http://www.kernel.org/hg/linux-2.6/

I still don't see something I can download into a local
hg or git repository -- if a lurker knows how that is done,
I'd be glad to know.


> Seems silly to use cpu_online_map to test for `1'?

Yeah - agreed.  The include/linux/cpumask.h stuff hardcodes
the UP (NR_CPUS==1) code to plain old 0's and 1's.  This
macro should do so as well.

I just sent a patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
