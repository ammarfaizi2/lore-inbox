Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUENEvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUENEvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 00:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUENEvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 00:51:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:31979 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264159AbUENEvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 00:51:04 -0400
Date: Thu, 13 May 2004 21:51:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040513215102.D22989@build.pdx.osdl.net>
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <200405140135.i4E1Zp7A025139@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405140135.i4E1Zp7A025139@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Thu, May 13, 2004 at 09:35:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> On Thu, 13 May 2004 18:20:10 PDT, Chris Wright said:
> 
> > I think it still needs more work.  Default behavoiur is changed, like
> > Inheritble is full rather than clear, setpcap is enabled, etc.  Also,
> > why do you change from Posix the way exec() updates capabilities?  Sure,
> > there is no filesystem bits present, so this changes the calculation,
> > but I'm not convinced it's as secure this way.  At least with newcaps=0.
> 
> The last time the "capabilities" thread reared its head a while ago, Andy made
> a posting that pretty conclusively showed that the Posix way was totally b0rken
> if you ever intended to support filesystem bits.  So if you wanted to ever have
> a snowball's chance of supporting something like:
> 
> chcap cap_net_raw+ep /bin/ping

It's still not clear that's what we want.  For now, just being able to have
the sucap equiv to sudo would be nice.  And it's very uncomfortable to
change mainline in subtle ways that could break security during stable
series.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
