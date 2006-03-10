Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752134AbWCJAqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbWCJAqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbWCJAqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:46:32 -0500
Received: from mx.pathscale.com ([64.160.42.68]:34191 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752134AbWCJAqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:46:30 -0500
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20]
	ipath - sysfs support for core driver)
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060310003513.GA17050@suse.de>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
	 <adapskvfbqe.fsf@cisco.com>
	 <1141947143.10693.40.camel@serpentine.pathscale.com>
	 <20060310003513.GA17050@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 16:46:29 -0800
Message-Id: <1141951589.10693.84.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 16:35 -0800, Greg KH wrote:

> Grumble?  Oh come on, don't export binary structures through sysfs, it's
> in the DOCUMENTATION THAT SYSFS IS FOR TEXT FILES ONLY!!!!

OK, fine.

> If you don't want to export a text file, then use something else other
> than sysfs, it's that simple.

Use what?  Would a sysfs relay file, or whatever they're called now that
relayfs is moving into sysfs, do the trick?  If so, what's a good place
to pull those patches from so I can compile-test my changes?  Should I
just grub through my archives and apply whatever Paul Mundt sent out a
few weeks ago?

> sysfs binary files are for PASS-THROUGH things ONLY!

If there's any documentation on what sysfs binary files are for, I
haven't seen it.  It's not in the include files, the source, or
Documentation/filesystems.  

> Ok, here's a new rule to help this from happening again in the future:
> 
>   If you want to add a new sysfs file to the kernel, it MUST be
>   accompanied with full documentation that explains exactly what that
>   file contains and what it is for.  No exceptions will be allowed.

I'm fine with this rule, but accompanied how?  In a comment in the code?
In the patch description?  In the same way that sysfs binary files are
documented? :-)

Also, I'd suggest that you put a similar requirement on directories and
symlinks, if you're going to clamp down on files.

	<b

