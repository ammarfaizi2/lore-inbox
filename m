Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTBTOIv>; Thu, 20 Feb 2003 09:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTBTOIv>; Thu, 20 Feb 2003 09:08:51 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:18865 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265457AbTBTOIu>;
	Thu, 20 Feb 2003 09:08:50 -0500
Date: Thu, 20 Feb 2003 14:31:13 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
Message-ID: <20030220143113.GB13507@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Zilvinas Valinskas <zilvinas@gemtek.lt>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <3E536237.8010502@blue-labs.org> <20030219185017.GA6091@gemtek.lt> <20030220133140.GA13507@codemonkey.org.uk> <1045749425.12753.90.camel@swoop.balt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045749425.12753.90.camel@swoop.balt.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 03:57:05PM +0200, Zilvinas Valinskas wrote:

 > it was the same with 2.5.59,2.5.60 (not sure now, I will check that
 > later) and with 2.5.61 (and yesterdays most current bk snapshot as
 > well).

.59 ? Ugh, a load of stuff has changed in agpgart/ since then.
Can you recall when it last actually worked for you ? 

 > Can it be related to DRI ? (that might be my guess).

You can test basic GART functionality with testgart
(http://www.codemonkey.org.uk/cruft/testgart.c)

 > Event though I
 > can't use DRI on debian unstable because libGL.so mistakenly recognizes
 > Pentium 4 as 3Dnow! capable and crashes immediately.

If thats what I think it is, its not a bug. This has come up a number
of times on the dri-devel list.
libGL does a test which runs 3dnow instructions. Obviouslly it'll
crash on a non-3dnow capable box, but prior to the test it installs
an exception handler to fix things up if it all goes awry.

Whats the debian bugzilla number for this bug out of interest ?

 > For some reasons always, once I log off - system reboots most of the
 > times when agpgart & agp-intel loaded (if these are not loaded) - DRI
 > can not be initialized and system is always stable during log off from 
 > KDE session.

The latter is normal, the former isn't (obviously).
Does it reboot as soon as you modprobe them, or when X/DRI starts ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
