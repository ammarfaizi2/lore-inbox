Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbUJWUHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUJWUHe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUJWUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:06:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:18063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbUJWUFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:05:09 -0400
Date: Sat, 23 Oct 2004 13:04:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041023130448.F2357@build.pdx.osdl.net>
References: <1097273105.1442.78.camel@krustophenia.net> <20041008151911.Q2357@build.pdx.osdl.net> <20041008152430.R2357@build.pdx.osdl.net> <87zn2wbt7c.fsf@sulphur.joq.us> <20041008221635.V2357@build.pdx.osdl.net> <87is9jc1eb.fsf@sulphur.joq.us> <20041009121141.X2357@build.pdx.osdl.net> <878yafbpsj.fsf@sulphur.joq.us> <20041009155339.Y2357@build.pdx.osdl.net> <874qkmtibt.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <874qkmtibt.fsf@sulphur.joq.us>; from joq@io.com on Fri, Oct 22, 2004 at 06:59:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jack O'Quin (joq@io.com) wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> > - less generic variable names
> >   - s/any/rt_any/
> >   - s/gid/rt_gid/
> >   - s/mlock/rt_mlock/
> 
> Is there a compelling reason for changing all the parameter names?

primarly for namespace cleanliness.  nice to avoid overly generic names
if possible.  makes it easier to search.

> I would prefer not to do that.  It is incompatible for our current
> user base, and really does not seem like an improvement.  Those names
> only appear in the context of `realtime', so the `rt_' is completely
> redundant.  For example...

Actually, I recall the change being 100% internal (not exposed
externally), but I'm away at the moment, so it's just from memory.

>  # modprobe realtime gid=29
>  # sysctl -w security/realtime/mlock=0
> 
> Also, you forgot to update the documentation.

I don't think it was needed due to above.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
