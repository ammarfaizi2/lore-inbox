Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269139AbUIXU7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269139AbUIXU7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269146AbUIXU7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:59:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:39067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269139AbUIXU7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:59:33 -0400
Date: Fri, 24 Sep 2004 13:59:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040924135931.V1924@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <4154867F.7030108@nortelnetworks.com> <20040924134602.U1924@build.pdx.osdl.net> <41548989.8040107@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41548989.8040107@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Fri, Sep 24, 2004 at 02:54:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Friesen (cfriesen@nortelnetworks.com) wrote:
> Chris Wright wrote:
> 
> > The info is stored in the memory mapping info that's necessarily blown
> > away at execve(2) because that's where you are overlaying a new image.
> 
> Yeah, I just saw that on the man page for mlockall.

It's required for SUSv3 (mlock too).

> I though maybe it was stored on the task struct or something.

Nope, default from MCL_FUTURE is ->mm->def_flags otherwise it's per
vma->vm_flags.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
