Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUENBB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUENBB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUENBB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:01:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:17863 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264269AbUENBB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:01:27 -0400
Date: Thu, 13 May 2004 18:01:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040513180124.C22989@build.pdx.osdl.net>
References: <fa.h4eq5gb.nj6q31@ifi.uio.no> <fa.gi5j8pu.92umbq@ifi.uio.no> <40A417EC.7010604@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40A417EC.7010604@myrealbox.com>; from luto@myrealbox.com on Thu, May 13, 2004 at 05:50:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> Chris Wright wrote:
> > What about something that's just simple and generic?  This is similar to
> > Andrea's disable_cap_mlock patch and the disabling capabilities patch
> > that wli produced back in that thread.  It would remove the hack, and
> > buy us some time to find better solutions.  Downside of course (as all
> > of these have) is reduced security value.
> 
> I actually like the magic group better.  This one means that _anyone_
> can DoS the system.  Why not just give Oracle its own LSM if this is
> what you want to do (that way the nastiness is completely isolated)?

Magic group has better safety property, but it evolved from
disable_cap_mlock which for CAP_IPC_LOCK has the identical property to
this patch.  Agreed it's safer w/out, but the magic group is so special
purpose that it feels like a hack.  This patch is more contained and
IMO is just a hold over until we have something that really works.

> <shameless_plug> My patch (posted a couple hours ago) solves this one
> cleanly </shameless_plug>

I'll comment on that separately ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
