Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263625AbUDUS5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUDUS5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUDUS53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:57:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:35456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263618AbUDUSyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:54:12 -0400
Date: Wed, 21 Apr 2004 11:54:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: compute_creds fixup in -mm
Message-ID: <20040421115411.M22989@build.pdx.osdl.net>
References: <20040421010621.L22989@build.pdx.osdl.net> <4086AEFC.5010002@myrealbox.com> <1082571199.9213.61.camel@moss-spartans.epoch.ncsc.mil> <20040421112827.O21045@build.pdx.osdl.net> <1082572971.9213.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082572971.9213.75.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Apr 21, 2004 at 02:42:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Wed, 2004-04-21 at 14:28, Chris Wright wrote:
> > * Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> > > I didn't see Chris' patch.  I assume that the worst case is unexpected
> > > program failure due to lack of capability, right?  The SELinux security
> > 
> > The opposite.  You'd get a program with non-root euid, but full
> > capability set, and AT_SECURE set false.  My patch is below.
> 
> Sorry, I wasn't clear.  I meant the worst case due to the share/ptrace
> state check being duplicated in SELinux and in commoncap, as opposed to
> being performed once as in Andy's patch.

Ah, indeed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
