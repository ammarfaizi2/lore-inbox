Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130872AbQLGQEM>; Thu, 7 Dec 2000 11:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130876AbQLGQEC>; Thu, 7 Dec 2000 11:04:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130872AbQLGQD7>; Thu, 7 Dec 2000 11:03:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Microsecond accuracy
Date: 7 Dec 2000 07:33:23 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90oak3$326$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0012071233420.970-100000@penguin.homenet> <Pine.LNX.4.21.0012071411170.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0012071411170.970-100000@penguin.homenet>
By author:    Tigran Aivazian <tigran@veritas.com>
In newsgroup: linux.dev.kernel
> 
> while we are on this subject, please let me emphasize that you should
> _not_ be using cpuid instruction to detect the presence of TSC but should
> parse the /proc/cpuinfo file. There are many valid reasons why Linux's
> idea of TSC presence may not be the same as hardware's (cpuid
> instruction) idea.
> 

Unfortunately the most important instance of the in-kernel flag -- the
global one in the somewhat misnamed boot_cpu_data.x86_features --
isn't actually readable in the /proc/cpuinfo file.  It is perfectly
possible (e.g. the "notsc" option) for ALL the CPUs to report this
capability, but the global capability to still be off.

I would like to have exported the global capabilities into
/proc/cpuinfo, but I'm worried about breaking software (the "flags"
versus "features" issue was bad enough -- unfortunately, in cases like
this, there probably is no "good" solution.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
