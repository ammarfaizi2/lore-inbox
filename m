Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266014AbRF1QUa>; Thu, 28 Jun 2001 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266015AbRF1QUU>; Thu, 28 Jun 2001 12:20:20 -0400
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:22174 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S266014AbRF1QUI>; Thu, 28 Jun 2001 12:20:08 -0400
Date: Thu, 28 Jun 2001 12:19:48 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: <wstearns@sparrow.websense.net>
Reply-To: William Stearns <wstearns@pobox.com>
To: Alan Cox <laughing@shared-source.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac20
In-Reply-To: <20010628164212.A27412@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0106281210030.3807-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	I also get an "Error in tcl script":

Error: can't read "CONFIG_DRM_AGP": no such variable.

	The stack trace is:

can't read "CONFIG_DRM_AGP": no such variable
    while executing
"list $CONFIG_DRM_AGP"
    (procedure "writeconfig" line 2351)
    invoked from within
"writeconfig .config include/linux/autoconf.h"
    invoked from within
".f0.right.save invoke"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke]"
    (procedure "tkButtonUp" line 7)
    invoked from within
"tkButtonUp .f0.right.save
"
    (command bound to event)

	scripts/kconfig.tk has this:

set CONFIG_DRM_AGP 4
	and
write_tristate $cfg $autocfg CONFIG_AGP $CONFIG_AGP [list $CONFIG_DRM_AGP] 2

	ac20 itself doesn't seem to have any references to CONFIG_DRM_AGP
at all.  Hmmm.

	If it makes a difference, the .config I used as a base has no
variables with either DRM or AGP in them.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"That vulnerability is completely theoretical."  -- Microsoft
	L0pht, Making the theoretical practical since 1992.
(Courtesy of "Deliduka, Bennet" <bennet.deliduka@state.vt.us>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

