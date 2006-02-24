Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWBXKrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWBXKrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 05:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWBXKrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 05:47:11 -0500
Received: from ns1.suse.de ([195.135.220.2]:10137 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750882AbWBXKrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 05:47:09 -0500
From: Andi Kleen <ak@suse.de>
To: Andres Salomon <dilinger@debian.org>
Subject: Re: [PATCH] x86_64 stack trace cleanup
Date: Fri, 24 Feb 2006 11:47:02 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1140777679.5073.17.camel@localhost.localdomain>
In-Reply-To: <1140777679.5073.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241147.03041.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 11:41, Andres Salomon wrote:
> Hi,
> 
> This patch cleans up the clutter of x86_64 stack traces, making the
> output closer to what i386 and sparc64 stack traces look like.  It uses
> print_symbol instead of resolving the symbols manually, and prints one
> frame per line instead of displaying multiple frames per line.  I left
> the other stuff in the stack dump alone; this affects only the frame
> list.
> 
> I know this has been brought up before
> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.0/2238.html,
> although I noticed a slight problem w/ that patch, as __print_symbol
> returns void); however, for people that don't spend all their time
> looking at x86_64 backtraces, I think this consistency shouldn't be
> scoffed at.  When you switch back and forth between different archs,
> x86_64's backtrace is cluttered and confusing in comparison.

If the formatting of the oopses is  your only problem you are a 
lucky man.

The problem is your new format uses more screen estate, which is precious
after an oops because the VGA scrollback is so small.
That is why i rejected the earlier attempts at changing this.

I can offer you a deal though: if you fix VGA scrollback to have
at least 1000 lines by default we can change the oops formatting too.

-Andi
