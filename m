Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVIFXNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVIFXNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVIFXNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:13:34 -0400
Received: from nevyn.them.org ([66.93.172.17]:19893 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750987AbVIFXNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:13:34 -0400
Date: Tue, 6 Sep 2005 19:13:32 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 SMP on AMD Athlon64 X2 + FC4: PS/2 keyboard b0rken; taskset/sched_setaffinity() saves the day!
Message-ID: <20050906231332.GA17523@nevyn.them.org>
Mail-Followup-To: Frank van Maarseveen <frankvm@frankvm.com>,
	linux-kernel@vger.kernel.org
References: <20050906211029.GA1638@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906211029.GA1638@janus>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 11:10:29PM +0200, Frank van Maarseveen wrote:
> While playing with a new AMD Athlon64 X2 3800+ (i386) the keyboard goes
> wild for 10 (20?) seconds, behaves normally for 10 (20?) seconds, and
> then goes wild again: when "wild", every keypress results in a random
> number of repeats, e.g.:
> 
> $ pppsss aaxxxuuuuuuuuuuu
> bash: pppsss: command not found
> $
> $
> $
> $
> $
> $
> $
> $
> 
> Upgrading Xorg to xorg-x11-6.8.2-37.FC4.45 did not help.
> 
> Booting with "nosmp" seems to fix it. And this _seems_ to fix it too:
> 
>         taskset -p 1 `ps axo comm,pid|awk '$1=="X"{print $2}'`
> 
> I haven't seen this problem on the console.

This is probably the same problem as the earlier one you reported.  If
you take a look at bugzilla, you'll see that the normal manifestation
is messed up key repeat rates...

-- 
Daniel Jacobowitz
CodeSourcery, LLC
