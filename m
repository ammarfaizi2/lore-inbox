Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbUDBBHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUDBBHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:07:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:29415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263500AbUDBBHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:07:08 -0500
Date: Thu, 1 Apr 2004 17:07:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401170705.Y22989@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040401135920.GF18585@dualathlon.random>; from andrea@suse.de on Thu, Apr 01, 2004 at 03:59:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> Oracle needs this sysctl, I designed it and Ken Chen implemented it. I
> guess google also won't dislike it.
> 
> This is a lot simpler than the mlock rlimit and this is people really
> need (not the rlimit). The rlimit thing can still be applied on top of
> this. This should be more efficient too (besides its simplicity).
> 
> can you apply to mainline?

This patch seems like the wrong hack to work around missing mlock rlimit
functionality.  Wouldn't it be better to fix the core problem, and leave
this patch out of mainline?  I agree with Rik, such a fix (mlock/rlimit)
will make all the gpg users feel warm and fuzzy ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
