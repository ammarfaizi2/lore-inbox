Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUHCWB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUHCWB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUHCWB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:01:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:3730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266897AbUHCWBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:01:19 -0400
Date: Tue, 3 Aug 2004 15:01:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803150118.Q1924@build.pdx.osdl.net>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com> <20040803213634.GK2241@dualathlon.random> <20040803213856.GB10978@devserv.devel.redhat.com> <20040803215150.GM2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040803215150.GM2241@dualathlon.random>; from andrea@suse.de on Tue, Aug 03, 2004 at 11:51:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Tue, Aug 03, 2004 at 11:38:57PM +0200, Arjan van de Ven wrote:
> > not if you keep track of who locked in the first place and give the credit
> > back to *that* user (struct).
> 
> I wasn't talking about chown above. I mean, where's the truncate that
> releases the user-struct-bind? 

I'm not sure what you mean.  Truncate should only update the accounting,
not break the binding, right?

> You just can't release the user-struct-bind from
> munlock/exit/whatever-task-opeartion-different-from-truncate-or-chown.

It's meant to be done at object destruction.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
