Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVAUAZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVAUAZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVAUAYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:24:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:33257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbVAUAX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:23:27 -0500
Date: Thu, 20 Jan 2005 16:23:25 -0800
From: Chris Wright <chrisw@osdl.org>
To: jnf <jnf@innocence-lost.us>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: linux capabilities ?
Message-ID: <20050120162325.O24171@build.pdx.osdl.net>
References: <Pine.LNX.4.61.0501201053070.24484@fhozvffvba.vaabprapr-ybfg.arg> <20050120134918.N469@build.pdx.osdl.net> <Pine.LNX.4.61.0501201547230.24484@fhozvffvba.vaabprapr-ybfg.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501201547230.24484@fhozvffvba.vaabprapr-ybfg.arg>; from jnf@innocence-lost.us on Thu, Jan 20, 2005 at 03:54:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jnf (jnf@innocence-lost.us) wrote:
> I will read the paper before commenting on it further, however I cannot
> see what dangers it would really provide that a setuid program doesnt
> already have- other than the ability to give another non-root process root
> like abilities. However, the more I ponder it, it seems as if you could

It was a dangerous failure mode when a capability isn't present that hit
sendmail.

> accomplish a lot of things with a set of ACL's and Capabilities (think
> compartmentalizing everything from each other where no one thing has full
> control of anything other than its particular subsystem).

Yes, that's the ideal.  Unfortunately it doesn't work out quite so
neatly ;-/

> > Since /proc/kmsg is 0400 you need CAP_DAC_READ_SEARCH (don't necessarily
> > need full override).  Otherwise, you are right, you do need CAP_SYS_ADMIN.
> > Or just use syslog(2) directly, and you'll avoid the DAC requirement.
> 
> Hrm, even a chmod of it didn't appear to really affect things?

Should, and it makes a difference for me.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
