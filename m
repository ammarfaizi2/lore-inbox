Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUIAWoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUIAWoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUIAWmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:42:19 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:50564 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267708AbUIAW0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:26:14 -0400
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200409012226.i81MQ7D19183@dbear.engr.sgi.com>
Subject: Re: [PATCH] improving JOB kernel/user interface
To: chrisw@osdl.org (Chris Wright)
Date: Wed, 1 Sep 2004 15:26:07 -0700 (PDT)
Cc: jh@SGI.com (John Hesterberg), limin@engr.sgi.com (Limin Gu),
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, erikj@SGI.com,
       chrisw@osdl.org
In-Reply-To: <20040901130623.F1924@build.pdx.osdl.net> from "Chris Wright" at Sep 01, 2004 01:06:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> * John Hesterberg (jh@sgi.com) wrote:
> > The current job /proc ioctl interface is really a fake-syscall interface.
> > We only did that so that our product didn't have to lock into a syscall
> > number that would eventually be used by something else.
> > 
> > The easiest thing for us would probably be to turn it back into a system
> > call, if that would be acceptable for inclusion into the kernel.  We're
> > open to other job interfaces, such as a real /proc character interface,
> > or a new virtual filesystem, or a device driver using ioctls.
> 
> But that system call would still be a single mutliplexor for many calls, right?
> Not ideal.  Have you tried to map to an fs?  It's nice and contained, and may be a
> simple mapping.  Question comes with CKRM, and if they'll have similar needs.  If
> that's the case, first class syscalls (no multiplexor) may be way to go.

Hi Chris,

I don't have much experience on implementing virtual filesystem, 
but I am willing to try it if that is the right interface for job. 
However, I am not sure how to map all current job ioctls to a 
nice and simple filesystem, at the same time I would like to keep 
the user library interface the same so our applications will not 
break.

Would you mind giving me some help on the job ioctls and fs
mapping? Thanks in advance!

Limin

> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> 

