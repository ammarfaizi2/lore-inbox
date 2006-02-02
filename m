Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423391AbWBBJB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423391AbWBBJB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423393AbWBBJB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:01:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423391AbWBBJB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:01:27 -0500
Date: Thu, 2 Feb 2006 01:00:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43E1C55A.7090801@drzeus.cx>
Message-ID: <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org>
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk>
 <43DE57C4.5010707@opersys.com> <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com>
 <200601302301.04582.brcha@users.sourceforge.net> <43E0E282.1000908@opersys.com>
 <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org> <43E1C55A.7090801@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Feb 2006, Pierre Ossman wrote:
> 
> The point is not only getting access to the source code, but also being able
> to change it. Being able to freely study the code is only half of the beauty
> of the GPL. The other half, being able to change it, can be very effectively
> stopped using DRM.

No it cannot.

Sure, DRM may mean that you can not _install_ or _run_ your changes on 
somebody elses hardware. But it in no way changes the fact that you got 
all the source code, and you can make changes (and use their changes) to 
it. That requirement has always been there, even with plain GPLv2. You 
have the source.

The difference? The hardware may only run signed kernels. The fact that 
the hardware is closed is a _hardware_ license issue. Not a software 
license issue. I'd suggest you take it up with your hardware vendor, and 
quite possibly just decide to not buy the hardware. Vote with your feet. 
Join the OpenCores groups. Make your own FPGA's.

And it's important to realize that signed kernels that you can't run in 
modified form under certain circumstances is not at all a bad idea in many 
cases.

For example, distributions signing the kernel modules (that are 
distributed under the GPL) that _they_ have compiled, and having their 
kernels either refuse to load them entirely (under a "secure policy") or 
marking the resulting kernel as "Tainted" (under a "less secure" policy) 
is a GOOD THING.

Notice how the current GPLv3 draft pretty clearly says that Red Hat would 
have to distribute their private keys so that anybody sign their own 
versions of the modules they recompile, in order to re-create their own 
versions of the signed binaries that Red Hat creates. That's INSANE.

Btw, what about signed RPM archives? How well do you think a secure 
auto-updater would work if it cannot trust digital signatures?

I think a lot of people may find that the GPLv3 "anti-DRM" measures aren't 
all that wonderful after all.

Because digital signatures and cryptography aren't just "bad DRM". They 
very much are "good security" too.

Babies and bathwater..

		Linus
