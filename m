Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUC3Qoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUC3Qoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:44:44 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:31749 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263741AbUC3Qnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:43:31 -0500
Date: Tue, 30 Mar 2004 17:20:24 +0200
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
Message-ID: <20040330152024.GE8304@DervishD>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos> <20040329222710.GA8204@DervishD> <Pine.LNX.4.53.0403300706500.5144@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0403300706500.5144@chaos>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard :)

 * Richard B. Johnson <root@chaos.analogic.com> dixit:
> >     Mmm, I'm confused. As far as I knew, you *should* use symlinks to
> > your current (running) kernel includes for /usr/include/asm and
> > /usr/include/linux. I've been doing this for years (in fact I
> > compiled my libc back in the 2.2 days IIRC), without problems. Why it
> > should be avoided and what kind of problems may arise if someone
> > (like me) has those symlinks?
> The libc headers end up including kernel headers via the sym-links.
> They must *only* use the headers with which libc was built. Therefore,
> any sym-links should be removed and replaced with a copy of the
> appropriate headers.

    Looking at my backups of 2001 (god bless backups...) I found that
the running kernel when I built my glibc (yes, I still use the same
glibc that in 2001...) was 2.4.10, so I'm going to replace the
symlinks with two real dirs with the headers from 2.4.10. Thanks a
lot for your help :)

> This comes about because the C library used kernel headers,
> which it shouldn't have done in the first place.

    Yes :(( I hope that in the next version that is fixed (and the
fact that the libc cannot be compiled with newer versions of GCC
because of an stupid bug in a prototype, but that's a very offtopic
matter...).
 
> FYI, you __never__ include C library headers when building
> any kernel modules.

    If I ever write a kernel module, I won't ;) Thanks for your help
:)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
