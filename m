Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVEGRvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVEGRvx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 13:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVEGRvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 13:51:52 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:48316 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262731AbVEGRvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 13:51:50 -0400
Message-ID: <427D00E8.4070208@stesmi.com>
Date: Sat, 07 May 2005 19:54:48 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050507075828.GF777@alpha.home.local>
In-Reply-To: <20050507075828.GF777@alpha.home.local>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

> I personally think that what would be useful is not "the number of CPUs"
> (which does not make any sense), but an enumeration of :
> 
>     - the physical nodes (for NUMA)
>     - the physical CPUs
>     - each CPU's cores (for multi-core)
>     - each core's siblings (for HT/SMT)
> 
> each of which would report their respective id for {set,get}_affinity().
> This way, the application would be able to choose how it needs to spread
> over available CPUs depending on its workload. But IMHO, this should
> definitely not be put in cpuinfo. I consider that cpuinfo is for the human.

When one defines it one way you can be sure there'll come some company
and figure something out that doesn't fit into that representation.

Like - Stick a board into the CPU slot of some motherboard. That board
has two DualCore, SMT chips.

Oops.

Now the funny part - there is a company selling those things (not
dualcore yet, but SMT anyhow).

How do you fit it into that model?

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCfQDoBrn2kJu9P78RAtUSAJ42Jm9xbpOE9UhOP7kpj5vGTuiPbACfXiB5
PnjLvgytXnlnrlKO+IVW5GE=
=ovm/
-----END PGP SIGNATURE-----
