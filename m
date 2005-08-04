Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVHDVbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVHDVbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVHDV2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:28:47 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:39042 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262709AbVHDV0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:26:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks-2
Date: Fri, 5 Aug 2005 07:20:17 +1000
User-Agent: KMail/1.8.2
Cc: Prakash Punnoor <prakash@punnoor.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com
References: <200508022225.31429.kernel@kolivas.org> <200508022328.09482.kernel@kolivas.org> <20050803211238.GA1291@elf.ucw.cz>
In-Reply-To: <20050803211238.GA1291@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508050720.18224.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 07:12, Pavel Machek wrote:
> Hi!
>
> > > > As promised, here is an updated patch for the newly released
> > > > 2.6.13-rc5. Boots and runs fine on P4HT (SMP+SMT kernel) built with
> > > > gcc 4.0.1.
> > >
> > > Doesn't compile for me w/ gcc 3.4.4:
> >
> > Thanks for the report. Tiny change required. Here is a respun patch.
>
> Sorry, it breaks my machine in "interesting" way. Cursor no longer
> blinks, sleep 1 takes more than five seconds, ...
>
> Pentium-M in compaq evo n620c notebok, cpufreq active:
>
> pavel@Elf:~$ dmesg | grep tick
> dyn-tick: Found suitable timer: tsc
> dyn-tick: Registering dynamic tick timer v050610-1
> dyn-tick: Maximum ticks to skip limited to 13
> dyn-tick: Timer not enabled during boot
> pavel@Elf:~$
>
> Ouch, even system time seems to go slower. I'll try setting
> DYNTICK_USE_APIC next.
> 								Pavel

I assume you've confirmed this doesn't happen in vanilla rc5?

Cheers,
Con
