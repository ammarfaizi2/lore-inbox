Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271904AbTG2WMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271938AbTG2WMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:12:40 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:8082 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S271904AbTG2WMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:12:39 -0400
Message-ID: <13036.134.121.40.89.1059516902.squirrel@mail.sandall.us>
In-Reply-To: <20030729204419.GE6049@waste.org>
References: <20030729204419.GE6049@waste.org>
Date: Tue, 29 Jul 2003 15:15:02 -0700 (PDT)
Subject: Re: [PATCH] automate patch names in kernel versions
From: "Eric Sandall" <eric@sandall.us>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oliver Xymoron said:
> Perhaps times have changed enough that I can revive this idea from a
> few years ago:
>
> http://groups.google.com/groups?q=patchname+oxymoron&hl=en&lr=&ie=UTF-8&selm=fa.jif8l5v.1b049jd%40ifi.uio.no&rnum=1
>
> <quote year=1999>
> This four-line patch provides a means for listing what patches have
> been built into a kernel. This will help track non-standard kernel
> versions, such as those released by Redhat, or Alan's ac series, etc.
> more easily.
>
> With this patch in place, each new patch can include a file of the
> form "patchname.[identifier]" in the top level source directory and
> [identifier] will then be added to the kernel version string. For
> instance, Alan's ac patches could include a file named patchdesc.ac2
> (containing a change log, perhaps), and the resulting kernel would be
> identified as 2.2.0-pre6+ac2, both at boot and by uname.
>
> This may prove especially useful for tracking problems with kernels
> built by distribution packagers and problems reported by automated
> tools.
> </quote>
>
> The patch now appends patches as -name rather than +name to avoid
> issues that might exist with packaging tools and scripts.
<snip>

One problem I see right off the bat with this is that your kernel image
name (and label) in LILO can only be so long, and if you apply too many
patches (acpi+xfs+preempt+low etc.) it would become too long.  This may be
an extreme case, but it can happen (I usually apply apci, preempt, low,
sched, etc., though the ck patch does most of this for me now).

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
