Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUIJVag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUIJVag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUIJVaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:30:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:45513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267903AbUIJV2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:28:39 -0400
Date: Fri, 10 Sep 2004 14:28:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040910142829.Q1924@build.pdx.osdl.net>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <41409378.5060908@ericsson.com> <20040909105520.U1924@build.pdx.osdl.net> <20040909190511.GB28807@escher.cs.wm.edu> <4140BFCE.8010701@ericsson.com> <20040909140349.C1924@build.pdx.osdl.net> <20040909214507.GA29412@escher.cs.wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909214507.GA29412@escher.cs.wm.edu>; from serue@us.ibm.com on Thu, Sep 09, 2004 at 05:45:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> > Thing is, x86 makes no distinction btween r/x so, have you tried mmaping
> > with read, then executing (I haven't)?
> 
> Yup, clearly that will work on x86.  And so obviously DigSig is not
> a solution to format and buffer overflows  :)  Nor, unfortunately, a

heh

> solution to code which for whatever reason exploited this behavior.

That's what I was getting at.  Beats me what's out there that does this,
but I expect some stuff does, and it wouldn't get the same assurance.

> > This has nothing to do with file permissions aside of read.  All you need
> > is read permission, then you can mmap(PROT_EXEC) which will kick off the
> > check, and do deny_write_access.  It's a freeform way to lock writers
> > out of any readable file in the system.
> 
> No, not "any readable file," because DigSig will not lock non-ELF files.

Ahh, this is the part I had missed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
