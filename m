Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUIQNyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUIQNyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUIQNya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:54:30 -0400
Received: from holomorphy.com ([207.189.100.168]:32684 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268760AbUIQNyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:54:16 -0400
Date: Fri, 17 Sep 2004 06:54:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040917135407.GU9106@holomorphy.com>
References: <20040915122920.GA4454@dualathlon.random> <20040915210106.GX9106@holomorphy.com> <20040915145524.079a8694.akpm@osdl.org> <20040915220016.GC9106@holomorphy.com> <20040915220819.GF15426@dualathlon.random> <4149539D.9070001@hist.no> <20040916142638.GW15426@dualathlon.random> <414AEB5E.30803@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414AEB5E.30803@hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:49:18PM +0200, Helge Hafting wrote:
> I am not talking about someone  accidentally stumbling onto
> something.  I was worried about someone deliberately
> trying to exploit this - such people look at data above i_size
> _because they can_, hoping to find something interesting there.
> Something they cannot get at normally.
> I am assuming that the "garbage" between i_size and the
> page boundary is stuff left over from whatever that
> memory page was used for earlier?  If so, it could be
> 4095 bytes out of the 4096 that was used to cache some
> other file earlier.  Possibly someone else's confidential file. 
> Or a piece of some network package that was processed a while ago.

This issue is only of userspace data leaking into pagecache at file
offsets just beyond where the end of a file formerly was (no further
than the former last page, but beyond the former end of the file), not
kernel data leaking to userspace.


-- wli
