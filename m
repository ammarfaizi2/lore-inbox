Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbTFNKrD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 06:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbTFNKrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 06:47:03 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:15313 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265592AbTFNKrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 06:47:01 -0400
Date: Sat, 14 Jun 2003 13:00:46 +0200 (MEST)
Message-Id: <200306141100.h5EB0kTk011731@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org, nemesis-lists@icequake.net
Subject: Re: Microstar MS-6163 blacklist
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003 20:46:46 -0500, Ryan Underwood wrote:
>In other news, I noticed recently that the IO-APIC on my MS-6163
>BX-Master was being disabled at boot by the kernel, due to a recently
>introduced blacklist:
>
>{ apm_kills_local_apic, "Microstar 6163",
>	{ MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
>	  MATCH(DMI_BOARD_NAME, "MS-6163"),
>	  NO_MATCH, NO_MATCH } },
>
>Consulting mailing list archives indicated that there is some sort of
>problem with the IO-APIC on the MS-6163 Pro and APM events.  However,
>this seems a rather clumsy fix to the problem, since it disabled the
>IO-APIC on _all_ MS-6163 boards rather than just the Pro, and also
>regardless of whether APM support is even enabled (I don't enable it and
>don't use it at all).

I added this blacklist rule last spring, but I'm also about to
submit a patch to Linus and Marcelo to remove it and the AL440LX
blacklist rule. You can read the full explanation then; suffice
it to say that using APM's DISPLAY_BLANK with certain graphics
cards causes hangs if the local APIC is enabled. You can just
remove the MS-6163 Pro blacklist rule for now.

/Mikael
