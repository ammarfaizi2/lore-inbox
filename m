Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbUKEBLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUKEBLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbUKEBHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:07:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:53735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262548AbUKEBF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:05:56 -0500
Date: Thu, 4 Nov 2004 17:05:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking
Message-ID: <20041104170555.G2357@build.pdx.osdl.net>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <20041104145229.D2357@build.pdx.osdl.net> <20041105010112.GC3792@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041105010112.GC3792@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Thu, Nov 04, 2004 at 07:01:12PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Hi,
> 
> Quoting Chris Wright (chrisw@osdl.org):
> ...
> > I think, all in all, this needs more work and more justification (esp.
> > w.r.t. overhead and impact on the current common use of a single
> > module).
> 
> Would it help to make CONFIG_NUM_LSMS a boot time option, and default
> to 1?

That number is only valid at compile time (it defines structure sizes,
etc).

> As for justification, the fact that many LSMS currently cannot be
> used simultaneously seemed the most prominent.  It certainly seems viable
> to use SELinux to protect audit logs and shadow files, use bsdjail to
> offer certain services, and use securelevel for some generic hardening,
> for instance.

Understood, although I don't think you'll get SELinux folks to agree
that it could be useful in conjuction with other modules like that.  The
real bottom line is that it can't slow anything down for the single
module case.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
