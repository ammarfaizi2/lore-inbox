Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVGEGIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVGEGIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 02:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVGEGIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 02:08:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:23275 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261381AbVGEGHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 02:07:33 -0400
Date: Mon, 4 Jul 2005 23:07:01 -0700
From: Greg KH <greg@kroah.com>
To: serge@hallyn.com
Cc: James Morris <jmorris@redhat.com>, Tony Jones <tonyj@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050705060700.GA29650@kroah.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com> <20050704155321.GA25153@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704155321.GA25153@vino.hallyn.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 10:53:21AM -0500, serge@hallyn.com wrote:
> > On Sun, Jul 03, 2005 at 02:53:17PM -0400, James Morris wrote:
> > > On Sun, 3 Jul 2005, Tony Jones wrote:
> > > 
> > > > There just isn't enough content to justify a stacker specific filesystem IMHO.
> > > 
> > > It might be worth thinking about a more general securityfs as part of LSM,
> > > to be used by stacker and LSM modules.  SELinux could use this instead of
> > > managing its own selinuxfs.
> > 
> > Good idea.  Here's a patch to do just that (compile tested only...)
> > 
> > Comments?
> 
> Tested without a hitch.

Thanks for testing.

> In addition, the attached patch converts seclvl to use the securityfs.
> Also tested without any problems.  (Only meant as proof of concept:
> Mike, you'll probably want to at least add the passwd_read_file
> function back in, I assume?)
> 
> --
> seclvl.c |  226 > +++++++++++++++++++++++++++------------------------------------
>  1 files changed, 99 insertions(+), 127 deletions(-)

Nice, glad to see this makes your code smaller and simpler.  Although I
think it could be made even smaller if you use the default read and
write file type functions in libfs (look at the debugfs wrappers of them
for u8, u16, etc, for examples of how to use them.)

thanks,

greg k-h
