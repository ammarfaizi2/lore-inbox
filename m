Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTJAXFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTJAXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:05:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:38296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262601AbTJAXF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:05:28 -0400
Date: Wed, 1 Oct 2003 16:05:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Chris Wright <chrisw@osdl.org>, Rik van Riel <riel@redhat.com>,
       torvalds@osdl.org, greg@kroah.com, vserver@solucorp.qc.ca
Subject: Re: [vserver] Re: sys_vserver
Message-ID: <20031001160526.R14398@osdlab.pdx.osdl.net>
References: <20031001115127.A14425@osdlab.pdx.osdl.net> <Pine.LNX.4.44.0310011454530.19538-100000@chimarrao.boston.redhat.com> <20031001121536.J14398@osdlab.pdx.osdl.net> <20031001194747.GA24632@DUK2.13thfloor.at> <20031001141654.N14398@osdlab.pdx.osdl.net> <20031001225247.GA26496@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031001225247.GA26496@DUK2.13thfloor.at>; from herbert@13thfloor.at on Thu, Oct 02, 2003 at 12:52:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Poetzl (herbert@13thfloor.at) wrote:
> 
> hmm, okay I see it now clearly, we should take
> the approach which was so successful for scsi ...
> 
> echo "vserver add-new-vserver 100 0 1 192 0 0 1" >/proc/1/attr/new
> 
> and of course to 'change' the context, a simple
> 
> echo "vserver change-to-old-context 100" >/proc/self/attr/migrate
> (and it was never seen again, because it vanished in context 100)
> 
> will be sufficient ...

Sorry if I don't follow your example correctly.  There is an attr/prev
as well as attr/current, if you are worried the previous context would
be lost.

> seriously I am completely on your side if we talk about
> limiting a process or changing it's environment, even
> if we talk about setting a class assignment, but I just 
> don't believe it's the perfect solution for everything ...

Yes, I agree, it won't be useful for everything, but where
possible/sensible, we should reuse it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
