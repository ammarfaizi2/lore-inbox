Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSJWTkk>; Wed, 23 Oct 2002 15:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265178AbSJWTkj>; Wed, 23 Oct 2002 15:40:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48133 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265177AbSJWTki>; Wed, 23 Oct 2002 15:40:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: One for the Security Guru's
Date: 23 Oct 2002 12:46:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ap6uae$4l8$1@cesium.transmeta.com>
References: <ap6idh$1pj$1@forge.intermeta.de> <Pine.LNX.4.44.0210230954270.17668-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0210230954270.17668-100000@dlang.diginsite.com>
By author:    David Lang <david.lang@digitalinsight.com>
In newsgroup: linux.dev.kernel
>
> yes someone who has root can get the effect of modules by patching
> /dev/kmem directly so eliminating module support does not eliminate all
> risk.
> 
> it does however eliminate the use of the rootkits that use kernel modules.
> 
> you need to decide if the advantages of useing modules are worth it for
> your situation.
> 

One thing about all of this that matters is the following:

It's not about how secure your system is.

It's about how smart/well equipped/patient the attacker needs to be
*once they have already broken into your system*.

I recently had one of my machines broken into, but the service in
question was not running as root, and the attacker wasn't able to find
any privilege-escalation bugs on my system.  I found a whole
collection of attempted security violations in a directory in /tmp,
and a daemon (called "bind" -- not "named") had been installed to get
access to my system again.  Needless to say, I cleaned that stuff up,
and also got a close look at the rootkit.

Since my machine hadn't succumbed to the rootkit, it seems the
attacker had simply moved on.  Most of these kinds of attacks are
actually automated these days, unless you're a high-value site for
them.

The kernel module, and/or replacing common user tools like ps, are
usually about trying to hide the existence of whatever
intrusion-installed software there is.  It really helps more on
"springboard" site than sites that are the genuine attack targets.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
