Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbUDBCJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUDBCJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:09:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25241
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263556AbUDBCJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:09:16 -0500
Date: Fri, 2 Apr 2004 04:09:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402020915.GO18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org> <20040401175914.A22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401175914.A22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 05:59:14PM -0800, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Rumour has it that the more exhasperated among us are brewing up a patch to
> > login.c which will allow capabilities to be retained after the setuid.  So
> > you do
> > 
> > 	echo "oracle CAP_IPC_LOCK" > /etc/logincap.conf
> > 
> > And that's it.
> > 
> > See any reason why this won't work?
> 
> Looks ok, and sounds very similar to what pam_cap does.

just curious, how does this work through 'su'? Does su check
logincap.conf too?

I certainly agree this can be fully solved in userspace, though it won't
be a few linear change in userspace and for the short term matter
there's not much time left to change userspace. For the long term if we
want to go with the userspace solution that's fine with me, I definitely
agree with that.  For the very short term I'm not sure, but then I
certainly cannot object if nothing is changed in the mainline kernel for
this.
