Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUIAUHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUIAUHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267604AbUIAUHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:07:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:32439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267601AbUIAUHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:07:09 -0400
Date: Wed, 1 Sep 2004 13:06:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: John Hesterberg <jh@sgi.com>
Cc: Limin Gu <limin@engr.sgi.com>, linux-kernel@vger.kernel.org,
       jlan@engr.sgi.com, erikj@sgi.com, chrisw@osdl.org
Subject: Re: [PATCH] improving JOB kernel/user interface
Message-ID: <20040901130623.F1924@build.pdx.osdl.net>
References: <4134FE16.2000308@engr.sgi.com> <20040901193829.GJ5886@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040901193829.GJ5886@sgi.com>; from jh@sgi.com on Wed, Sep 01, 2004 at 02:38:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Hesterberg (jh@sgi.com) wrote:
> The current job /proc ioctl interface is really a fake-syscall interface.
> We only did that so that our product didn't have to lock into a syscall
> number that would eventually be used by something else.
> 
> The easiest thing for us would probably be to turn it back into a system
> call, if that would be acceptable for inclusion into the kernel.  We're
> open to other job interfaces, such as a real /proc character interface,
> or a new virtual filesystem, or a device driver using ioctls.

But that system call would still be a single mutliplexor for many calls, right?
Not ideal.  Have you tried to map to an fs?  It's nice and contained, and may be a
simple mapping.  Question comes with CKRM, and if they'll have similar needs.  If
that's the case, first class syscalls (no multiplexor) may be way to go.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
