Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUIXUrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUIXUrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269140AbUIXUqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:46:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:45459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269146AbUIXUqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:46:07 -0400
Date: Fri, 24 Sep 2004 13:46:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040924134602.U1924@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <4154867F.7030108@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4154867F.7030108@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Fri, Sep 24, 2004 at 02:41:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Friesen (cfriesen@nortelnetworks.com) wrote:
> Chris Wright wrote:
> 
> > 2. Problem is the execve(2) that the mlock(1) program would have to call.
> > This blows away the mappings which contain the locking info.
> 
> Does it?  The man page said it isn't inherited on fork(), but why wouldn't it 
> be inherited on exec()?

The info is stored in the memory mapping info that's necessarily blown
away at execve(2) because that's where you are overlaying a new image.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
