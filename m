Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbTE0UMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264121AbTE0UMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:12:22 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:54832 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264106AbTE0UMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:12:20 -0400
Subject: Re: APIC on Dell Laptops - WAS: Re: [RFC] Fix NMI watchdog
	documentation
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1053978298.6152.25.camel@slappy>
References: <200305260921.h4Q9LcNr022536@harpo.it.uu.se>
	 <1053967225.5948.12.camel@slappy>
	 <16082.24332.881881.965677@gargle.gargle.HOWL>
	 <1053978298.6152.25.camel@slappy>
Content-Type: text/plain
Organization: 
Message-Id: <1054067120.6085.4.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 May 2003 16:25:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 14:38, mikpe@csd.uu.se wrote:
> Disconnect writes:
>  > Local APIC disabled by BIOS -- reenabling.
>  > Found and enabled local APIC!
>  > 
>  > And now /proc/cpuinfo and cpuid both show APIC support.
>  > 
>  > Removed/replaced power, triggered lid-switch/battery-status/etc with no
>  > issues.  (The only thing that caused trouble was Fn-F10, the "eject cd"
>  > button.  Never tried it under Linux before, and the cd isn't in it at
>  > the moment anyway, so I'm betting thats unrelated. But it did cause a
>  > lockup that even sysrq couldn't recover.)
> 
> Nice.

..and it gets better. Not sure what the exact problem is (updated DRM, X
etc) but Fn-F8 (CRT/LCD) hardlocks. With the no-APIC kernel (same new
DRM and so forth) it just hesitates (not sure if it works or not,
haven't got a monitor handy.)  It worked (or at least didn't lock up)
when I initially tried it, but now I can reproduce it well before X
comes up.

Looks like it should be dropped from the whitelist :(  (To recap, this
is the Inspiron 8500 w/ A02 bios)

-- 
Disconnect <lkml@sigkill.net>

