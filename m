Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTKYAf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTKYAf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:35:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:39140 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261683AbTKYAf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:35:56 -0500
Date: Mon, 24 Nov 2003 16:35:53 -0800
From: Chris Wright <chrisw@osdl.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031124163553.B16684@osdlab.pdx.osdl.net>
References: <200311241736.23824.jlell@JakobLell.de> <bpu5fk$vsn$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <bpu5fk$vsn$1@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Nov 24, 2003 at 11:50:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* bill davidsen (davidsen@tmr.com) wrote:
> 
> While I think you're overblowing the problem, it is an issue which might
> be addressed in SE Linux or somewhere. I have an idea on that, but I
> want to look before I suggest anything.

SELinux controls hard link creation by checking, among other things,
the security context of the process attempting the link, and the security
context of the target (oldpath).  Other MAC systems do similar, and some
patches such as grsec and owl simply disable linking to files the user
can't read/write to for example.

> Bear in mind it isn't a "problem" it's 'expected behaviour" for the o/s,
> and might even be mentioned in SuS somehow. Interesting topic, but not a
> bug, since the behaviour is as intended.

SuS states:
	
	The implementation may require that the calling process has
	permission to access the existing file.

Note the use of *may*.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
