Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbULTEXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbULTEXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 23:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbULTEXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 23:23:08 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:36560 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261412AbULTEXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 23:23:02 -0500
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with
	workaround...
From: Steven Rostedt <rostedt@goodmis.org>
To: Joe <joecool1029@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d4757e60041219184662648df@mail.gmail.com>
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
	 <1103300362.12664.53.camel@localhost.localdomain>
	 <1103303011.12664.58.camel@localhost.localdomain>
	 <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
	 <1103313861.12664.71.camel@localhost.localdomain>
	 <1103320354.3538.11.camel@localhost.localdomain>
	 <200412172242.iBHMgVav003005@turing-police.cc.vt.edu>
	 <1103473203.4143.9.camel@localhost.localdomain>
	 <d4757e60041219184662648df@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 19 Dec 2004 23:22:50 -0500
Message-Id: <1103516570.4143.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-19 at 21:46 -0500, Joe wrote:
> Nope, I've experianced the same problem without SMP.  It also appears
> to be a bug where if make menuconfig is not run after using an old
> kernel, for some odd reason CONFIG_SPINLOCK_BKL is set to be on. 
> Anyways, I just wanted to reassure you, this is NOT an SMP bug.

I'm not sure Valdis' problem is the same as mine, so I can't say that
mine is not an SMP problem. There may be two problems here, and mine was
indeed SMP (since turning it off allowed me to get X up and running with
the NVidia module). The problem Valdis has mentioned, may be a separate
issue that has nothing to do with SMP. Now, w.r.t. the problem you saw,
was that only when CONFIG_SPINLOCK_BKL was set?

Now, I'm trying the NVidia again (well tomorrow, since I need to
recompile my entire kernel again to get back to SMP), and I've changed
the nvidia driver to us raw_spinlocks instead of normal ones to see if
this fixes things.  Ah, I've only changed the GPL part of the nvidia
driver (obviously).

This isn't really necessary for my real work, since I'm not required to
get this working with NVidia, but since three of my machines have an
NVidia card, this is more a personally fix I would like to have.
Otherwise, I just keep the old nv driver.

-- Steve


