Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbTCLPHy>; Wed, 12 Mar 2003 10:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261655AbTCLPHy>; Wed, 12 Mar 2003 10:07:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26894 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261631AbTCLPHx>; Wed, 12 Mar 2003 10:07:53 -0500
Date: Wed, 12 Mar 2003 07:16:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [patch 3/3] add Via Nehemiah ("xstore") rng support
In-Reply-To: <20030312125542.GA4284@suse.de>
Message-ID: <Pine.LNX.4.44.0303120714030.13807-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Dave Jones wrote:
>  
>  > +#define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
>  
> Do we want to do this check only on VIA CPUs I wonder.
> As a vendor specific extension, I'd be inclined to do that.

No, the whole point of all the crud in arch/i386/kernel/cpu is to make 
those tests _once_ at bootup, and then the internal kernel "extended CPU 
feature set" has a unique feature-set that is independent of manufacturers 
and totally disjunct, so that we never need to care about manufacturers 
ever again.

		Linus

