Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUIIUqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUIIUqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUIIUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:45:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:38856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266137AbUIIUor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:44:47 -0400
Date: Thu, 9 Sep 2004 13:44:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909134423.O1973@build.pdx.osdl.net>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909175342.GA27518@k3.hellgate.ch>; from rl@hellgate.ch on Thu, Sep 09, 2004 at 07:53:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Luethi (rl@hellgate.ch) wrote:
> On Thu, 09 Sep 2004 10:22:00 -0700, William Lee Irwin III wrote:
> > On Thu, Sep 09, 2004 at 07:53:31AM -0400, Stephen Smalley wrote:
> > > They aren't world readable when using a security module like SELinux;
> > > they are then typically only accessible by processes in the same
> > > security domain, aside from processes in privileged domains. 
> > > security_task_to_inode() hook sets the security attributes on the
> > > /proc/pid inodes based on their security context, and then
> > > security_inode_permission() hook controls access to them.  So you need
> > > at least comparable controls.
> > 
> > Can you make a more specific suggestion regarding the controls to use?
> > It's a bit awkward for those highly unfamiliar with the subsystem to
> 
> For the same reason, I'm not comfortable with implementing SELinux type
> access controls myself. How about:
> 
> config NPROC
> 	depends on !SECURITY_SELINUX
> 
It's not just SELinux, it's any security module (i.e. CONFIG_SECURITY for
starters).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
