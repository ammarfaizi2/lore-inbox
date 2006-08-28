Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWH1Tdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWH1Tdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWH1Tdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:33:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751368AbWH1Tdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:33:50 -0400
Date: Mon, 28 Aug 2006 12:33:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: "Miles Lane" <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc4-mm3 -- intel8x0 audio busted
Message-Id: <20060828123344.fc580902.akpm@osdl.org>
In-Reply-To: <p737j0s7kad.fsf@verdi.suse.de>
References: <a44ae5cd0608262355q51279259lc6480f229e520fd5@mail.gmail.com>
	<s5hac5o7v47.wl%tiwai@suse.de>
	<20060828114939.90341479.akpm@osdl.org>
	<p737j0s7kad.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2006 21:05:46 +0200
Andi Kleen <ak@suse.de> wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > 
> > No, they're just a little warning we put in there to find out how
> > removeable sys_sysctl() is.  (Answer: not very.  I'll drop that patch).
> 
> I made the same experiment some time ago -- all of them use only a single
> sysctl (KERN_VERSION). If that one is emulated there are basically no users 
> left. I can resend a patch to warn only for those that are not KERN_VERSION
> if there is interest.
> 

Yes, that would be useful, thanks.

Eric, it sounds like one way to settle this would be to keep sys_sysctl()
if CONFIG_SYSCTL_SYSCALL=n, but only a stripped-down version which supports
KERN_VERSION.  And which spits a once-per-boot warning so people stop using
it one day.

Or we give up and go do something else.  This is all a bit of a pita.

