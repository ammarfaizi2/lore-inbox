Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUDNQux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUDNQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:50:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:49038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264283AbUDNQtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:49:36 -0400
Date: Wed, 14 Apr 2004 09:49:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mq_open() and close_on_exec?
Message-ID: <20040414094932.Q21045@build.pdx.osdl.net>
References: <20040413174005.Q22989@build.pdx.osdl.net> <407CC26D.6070307@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <407CC26D.6070307@colorfullife.com>; from manfred@colorfullife.com on Wed, Apr 14, 2004 at 06:47:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Manfred Spraul (manfred@colorfullife.com) wrote:
> Chris Wright wrote:
> >SUSv3 doesn't seem to specify one way or the other.  I don't have the
> >POSIX specs, and the old docs I have suggest that mq_open() creates an
> >object which is to be closed upon exec.  Anyone have a clue if this is
> >actually required?  Patch below sets this as default (if indeed it's
> >valid/required).
> >
> Did you test what other unices do? I think the patch is correct - at 
> least solaris implements message queues in user space, and then an exec 
> should close everything.

No, I haven't.  Looks like I missed the SUSv3 specification that indeed
requires closing on exec.  So, I believe the patch is needed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
