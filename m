Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVBDSa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVBDSa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVBDSaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:30:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:40166 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265825AbVBDS1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:27:45 -0500
Date: Fri, 4 Feb 2005 10:27:39 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] Fix selinux_inode_setattr hook
Message-ID: <20050204102739.P24171@build.pdx.osdl.net>
References: <1107539956.8078.109.camel@moss-spartans.epoch.ncsc.mil> <20050204101440.N24171@build.pdx.osdl.net> <1107540806.8078.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1107540806.8078.114.camel@moss-spartans.epoch.ncsc.mil>; from sds@tycho.nsa.gov on Fri, Feb 04, 2005 at 01:13:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> On Fri, 2005-02-04 at 13:14, Chris Wright wrote:
> > * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > > This patch against 2.6.11-rc3 fixes the selinux_inode_setattr hook
> > > function to honor the ATTR_FORCE flag, skipping any permission checking
> > > in that case.  Otherwise, it is possible though unlikely for a denial
> > > from the hook to prevent proper updating, e.g. for remove_suid upon
> > > writing to a file.  This would only occur if the process had write
> > > permission to a suid file but lacked setattr permission to it.  Please
> > > apply.
> > 
> > Is there any reason not to promote this to the framework?
> 
> I wasn't sure if a security module might still want to be notified of
> forced changes (e.g. to adjust some state in its own security
> structure), even if it skips permission checking on such changes.

OK, let's go with your patch for now.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
