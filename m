Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbSJBQ1Y>; Wed, 2 Oct 2002 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJBQ1Y>; Wed, 2 Oct 2002 12:27:24 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:33263 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263149AbSJBQ1X>; Wed, 2 Oct 2002 12:27:23 -0400
Date: Wed, 2 Oct 2002 09:25:19 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Capabilities-related change in 2.5.40
Message-ID: <20021002092519.C26557@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021001164907.GA25307@nevyn.them.org> <20021001134552.A26557@figure1.int.wirex.com> <20021001211210.GA8784@nevyn.them.org> <20021002003817.B26557@figure1.int.wirex.com> <20021002132331.GA17376@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021002132331.GA17376@nevyn.them.org>; from dan@debian.org on Wed, Oct 02, 2002 at 09:23:31AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Jacobowitz (dan@debian.org) wrote:
> 
> Look at cap_proc.c:_libcap_cappid :

Right, but cap_get_proc calls _libcap_cappid with pid of 0.  At any
rate, I believe pid == 0 is intentional to pick up the current
capabilities.

> How very odd.  I have been running 2.5 on that machine for a while, and
> the bug only showed up somewhere between 2.5.36 and 2.5.40.  Maybe a
> coincidence triggered by the PID hashing... your tabbing is a little
> odd but the patch looks right to me.  Thanks!

I tried on various older 2.5 kernels (> 2.5.20) and they returned -ESRCH.
I agree, the PID hashing probably started picking up swapper.  And yes
the tabbing is odd.  The file is badly in need of Lindent, as it's mostly
space tabbed.  I didn't want to hide the patch in whitespace changes ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
