Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUI0VMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUI0VMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267396AbUI0VMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:12:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267385AbUI0VK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:10:28 -0400
Date: Mon, 27 Sep 2004 17:10:11 -0400
From: Alan Cox <alan@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: Patch for comment: setuid core dumps
Message-ID: <20040927211011.GA15168@devserv.devel.redhat.com>
References: <20040927202616.GA22228@devserv.devel.redhat.com> <20040927140353.Z1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927140353.Z1973@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 02:03:53PM -0700, Chris Wright wrote:
> > +2 - (suidsafe) - any binary which normally not be dumped is dumped
> > +	readable by root only. This allows the end user to remove
> > +	such a dump but not access it directly. For security reasons
> > +	core dumps in this mode will not overwrite one another or 
> > +	other files. This mode is appropriate when adminstrators are
> > +	attempting to debug problems in a normal environment.
> > +
> 
> But, in general, did you double check how this plays with /proc
> (task_dumpable) and ptrace_attach type stuff?  That seems sketchy.

I reviewed it in terms of ptrace. I'll review the /proc stuff in detail. I'd
not given that anything like sufficient thought.
