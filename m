Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUC3RPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbUC3RP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:15:29 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:25608 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263780AbUC3RPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:15:18 -0500
Date: Tue, 30 Mar 2004 19:10:24 +0200
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Matthew Reppert <repp0017@tc.umn.edu>, Lev Lvovsky <lists1@sonous.com>,
       linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
Message-ID: <20040330171024.GT8304@DervishD>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Matthew Reppert <repp0017@tc.umn.edu>,
	Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos> <20040329222710.GA8204@DervishD> <1080604519.32741.8.camel@minerva> <20040330145013.GD8304@DervishD> <Pine.LNX.4.53.0403301001090.6371@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0403301001090.6371@chaos>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard :)

 * Richard B. Johnson <root@chaos.analogic.com> dixit:
[Kernel-related userspace tools]
> That's why you should use an 'include' search path on the
> compiler command line when you are compiling these. The search
> path should point to the kernel headers of the version you
> intend to use. The kernel tries to remain compatible, but
> when you access internal structures, compatibility may be lost.

    So, as a rule of thumb, anytime I compile or install such
programs, I should set an include search path for them.
 
> >     If I've understood correctly, these tools (like hdparm) should
> > *not* use current (running) kernel headers, but those that were in
> > use when glibc was built, am I right? Which, BTW, is a big problem
> > because I don't have the slightest idea about which kernel was in use
> > when I built my glibc.
> Yes. One can usually 'trust' a distribution and use whatever they
> shipped.

    I don't use a distro, I have a do-it-yourself linux box, part of
it is from an old Debian 1.3.1, but most of it is hand-made. I
compile my own kernel-related tools. I suppose that, for each package
I install that may be kernel-related, I should do 'grep "<linux/"'
just in case...
 
> >     But putting under /usr/include/linux and /usr/include/asm the
> > headers in use when glibc is built can lead to a problem, too.
> > Imagine that at some point in the future, the contents of the asm or
> > linux dirs depends on which facilities the kernel has configured
> > e.g. no scsi.h if no scsi support is present in the configured
> > kernel. That way, you don't have scsi.h under your
> > /usr/include/linux, but you may need it if you add an SCSI card with
> > your running kernel and want to compile some 'scsiutils' or whatever
> > like that.
> No. User-mode programs must never, never, never, ever include
> kernel headers directly. Instead, if they are for kernel utilities,
> the include search-path must be explicitly set.

    Nice. But I don't feel it is current practice... For example,
hdparm doesn't set such include search path, iproute2 does but
modutils (up to 2.4.27, AFAIK) doesn't... I don't know many more
examples, so I may well be wrong.
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
