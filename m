Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbVJEVbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbVJEVbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVJEVbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:31:21 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:6407 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030314AbVJEVbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:31:21 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	<35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
	<87oe66r62s.fsf@amaterasu.srvr.nix>
	<20051003153515.GW7992@ftp.linux.org.uk>
	<87zmpqbcws.fsf@amaterasu.srvr.nix>
	<21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: the Swiss Army of Editors.
Date: Wed, 05 Oct 2005 22:31:11 +0100
In-Reply-To: <21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com> (Dave
 Airlie's message of "Thu, 6 Oct 2005 07:11:36 +1000")
Message-ID: <87br23odls.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Dave Airlie announced authoritatively:
>> (Current rant: DRM churn, forcing one of abandonment of decent 3D
>> support, or upgrading of the X server to the bleeding-edge, or using an
>> old kernel with known security holes, or becoming enough of a DRI
>> developer to backport the changes, or using nothing but distro kernels
>> <=2.6.11. Most of these are not terribly feasible for me right now. Ah
>> well, my 3D card is total crap anyway. It's just a shame the X server
>> crashes whenever asked to do in-software 3D rendering...  time to
>> debug. I thought I might actually get some work done this evening. Fat
>> chance.)
> 
> This is just mach64, we don't have mach64 support in the kernel so it
> has nothing to do with the kernel... I've no idea why mach64 broke but

I misspoke. Some of the non-DRM API changes around 2.6.12 broke the
6.8.2 mach64 module in DRI CVS; the development version builds again,
and nearly works.

> upgrading everything won't fix it.. the kernel-drm and userspace do
> not need to be kept in any sort of lockstep,

I could swear that I've encountered problems in the past due to
upgrading one and not the other, but since I can't actually remember
what those problems *were*, I'll shut up.

>                                              and the mach64 dri code
> hasn't been touched by anyone in > 1 year probably even two.. (I was
> last person to own one to test it on...)

I'd not have got a mach64 if I hadn't got the machine free. I hear
R9200s are the most useful 3D cards with free drivers around at the
moment: I suppose I should get one. (It's not as though the Mach64's
hardware 3D support is significantly faster than software rendering on
this 1300MHz Athlon anyway.)

> If you could nail down exactly when it went south then we can fix
> it... but giving out here won't help anyone..

It was just a random rant: I know that I can't really complain until
I've tried the development version, so I've built up 6.8.99.900, which
nearly half sort-of works, modulo only fdo bugs #4574 (which bug breaks
the mach64 DRM module, but at least it builds and modprobes OK), and
#4696 (which kills the X server and is probably a Mesa bug rather than
anything Mach64-specific).

No kernel-tree problems, really, and I'm not complaining about the speed
of kernel development at all, let alone asking for some mythical and
restrictive stable module API. I'm just wondering if I'll ever be able
to use DRI for more than a month at a time without something breaking it
:( such are the risks of using a card with out-of-tree DRM support.


(Aside: I must say I'm damn impressed by the X server's internal API
stability. I screwed up the installation of X.org 6.8.99.900, and for a
day or so was unknowingly running the X.org 6.8.2 X server against the
6.8.99.900 modules. Except for problems drawing certain small pixmaps,
it seemed to work perfectly well!)

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
