Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVBXDHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVBXDHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVBXDHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:07:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:26535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVBXDGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:06:55 -0500
Date: Wed, 23 Feb 2005 19:06:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] show RLIMIT_SIGPENDING usage in /proc/PID/status
Message-ID: <20050224030643.GB28536@shell0.pdx.osdl.net>
References: <20050224023349.GF15867@shell0.pdx.osdl.net> <200502240255.j1O2tj8M010857@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502240255.j1O2tj8M010857@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> > Two questions: 1) This changes the interface for consumers of
> > /proc/[pid]/status data, do we care?  Adding new line like this should be
> > safe enough.
> 
> As far as I can tell, noone fretted about the addition of Threads:,
> ShdPnd:, etc., which were not always there.

Sounds good ;-)

> > 2) Perhaps we should do /proc/[pid]/rlimit/ type dir for each value?
> >    This has been asked for before.
> 
> Is the request to see the limit settings, or the current usage, or both?
> What kind of format are you suggesting?  I don't see a need for something
> with a million little files.  Also, for some of the limits the correct
> current usage count is not trivial to ascertain.  (And for others like
> RLIMIT_FSIZE and RLIMIT_CORE, it is of course not meaningful at all.)

Probably just one file per rlimit with usage, cur, max.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
