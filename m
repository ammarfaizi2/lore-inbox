Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265657AbUABUib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUABUib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:38:31 -0500
Received: from users.ccur.com ([208.248.32.211]:9624 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S265657AbUABUia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:38:30 -0500
Date: Fri, 2 Jan 2004 15:38:21 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       albert.cahalan@ccur.com, jim.houston@ccur.com
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
Message-ID: <20040102203820.GA3147@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20040102194909.GA2990@rudolph.ccur.com> <Pine.LNX.4.58.0401021226150.5282@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401021226150.5282@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ resend, accidently sent originally from a broken email account ]

> On Fri, 2 Jan 2004, Joe Korty wrote:
>> siginfo_t processing is fragile when in 32 bit compatibility mode on
>> a 64 bit processor.
> 
> It shouldn't be.
> Inside the kernel, we should always use the "native" format (ie 64-bit). 

Indeed we do, and that is the problem.  32 bit apps by definition use
the 32 bit version of siginfo_t and the first act the kernel has to do
on receiving one of these is convert it to 64 bit for consumption by
the rest of the kernel.  In order to do that, the kernel must know what
fields in siginfo_t the user has set.

Joe

