Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUDBCaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUDBCae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:30:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:21681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263104AbUDBCad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:30:33 -0500
Date: Thu, 1 Apr 2004 18:30:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040401183026.6844597a.akpm@osdl.org>
In-Reply-To: <20040402020915.GO18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random>
	<20040401170705.Y22989@build.pdx.osdl.net>
	<20040401173034.16e79fee.akpm@osdl.org>
	<20040401175914.A22989@build.pdx.osdl.net>
	<20040402020915.GO18585@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Apr 01, 2004 at 05:59:14PM -0800, Chris Wright wrote:
> > * Andrew Morton (akpm@osdl.org) wrote:
> > > Rumour has it that the more exhasperated among us are brewing up a patch to
> > > login.c which will allow capabilities to be retained after the setuid.  So
> > > you do
> > > 
> > > 	echo "oracle CAP_IPC_LOCK" > /etc/logincap.conf
> > > 
> > > And that's it.
> > > 
> > > See any reason why this won't work?
> > 
> > Looks ok, and sounds very similar to what pam_cap does.
> 
> just curious, how does this work through 'su'? Does su check
> logincap.conf too?

I guess so.

> I certainly agree this can be fully solved in userspace, though it won't
> be a few linear change in userspace and for the short term matter
> there's not much time left to change userspace. For the long term if we
> want to go with the userspace solution that's fine with me, I definitely
> agree with that.  For the very short term I'm not sure, but then I
> certainly cannot object if nothing is changed in the mainline kernel for
> this.

Well you have a local short-term solution...

One thing I was wondering was whether /proc/sys/vm/disable_cap_mlock should
hold a GID rather than a boolean.  So you do

	echo groupof oracle > /proc/sys/vm/disable_cap_mlock



