Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284432AbRLQAyW>; Sun, 16 Dec 2001 19:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284948AbRLQAyM>; Sun, 16 Dec 2001 19:54:12 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:51150 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S284432AbRLQAyB>; Sun, 16 Dec 2001 19:54:01 -0500
Date: Sun, 16 Dec 2001 19:53:43 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Tony Hoyle <tmh@nothing-on.tv>
cc: Ben Carrell <ben@xmission.com>, linux-kernel@vger.kernel.org,
        "Michael P. Soulier" <michael.soulier@rogers.com>
Subject: Re: can't compile 2.4.16
In-Reply-To: <3C1D3F76.2080008@nothing-on.tv>
Message-ID: <Pine.A41.4.21L1.0112161948420.53212-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

% bzcat ~/tmp/kernel/patch-2.4.17-rc1.bz2|grep devexit|wc -l
81

So no, the fixes have not been reverted. Also, John and I have submitted
additional patches for __devexit.

For Debian, the last known version of binutils in sid that didn't cause
these messages was purged a while ago. Look in /var/cache/apt/archives/
if you keep them there, or perhaps someone you know may have it lying
around.

I'll take a look at net/ tonight, but drivers/ should be completely
converted to __devexit as of John's patch
(http://marc.theaimsgroup.com/?l=linux-kernel&m=100848516505140&w=2).

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Mon, 17 Dec 2001, Tony Hoyle wrote:

> Has this fix been reverted?  It isn't in -pre8 or -rc1.
> 
> 
> net/network.o(.text.lock+0x17b8): undefined reference to `local symbols 
> in discarded section .text.exit'
> 
> It's kind of impossible to compile the kernel at the moment (even the 
> CONFIG_HOTPLUG fix mentioned doesn't work).
> 
> I tried downgrading binutils & it didn't work.. possibly I didn't go 
> back far enough.  What is the newest version that is supposed to work?
> 
> Tony

