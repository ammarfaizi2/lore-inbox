Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUIJMTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUIJMTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUIJMTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:19:06 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:56254 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267381AbUIJMRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:17:14 -0400
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Roger Luethi <rl@hellgate.ch>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20040909134854.B1924@build.pdx.osdl.net>
References: <20040908184130.GA12691@k3.hellgate.ch>
	 <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20040909172200.GX3106@holomorphy.com>
	 <20040909175342.GA27518@k3.hellgate.ch>
	 <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil>
	 <20040909134854.B1924@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1094818271.28310.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 08:11:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 16:48, Chris Wright wrote:
> > + * @task_getstate:
> > + * 	Check permission before getting the state of a task.
> > + *      @pid contains the pid of the requesting process.
> > + *	@p contains the task_struct for the target task.
> > + *      @uid contains the uid of the requesting process.
> > + *      @caps contains the capability set of the requesting process.
> > + *      Return 0 if permission is granted.
> 
> Why caps?

It is readily available in the netlink skb parms, and someone might want
to use it, e.g. a security module might limit a requesting process to
only getting state of other processes with the same uid unless the
requesting process has some capability.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

