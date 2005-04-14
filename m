Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVDNQyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVDNQyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVDNQyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 12:54:50 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:24762 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S261543AbVDNQyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 12:54:44 -0400
Message-ID: <425E9FE2.6090102@tin.it>
Date: Thu, 14 Apr 2005 11:52:50 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCEE4F1A8F151E555A102B67C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCEE4F1A8F151E555A102B67C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Lang wrote:
> some config changes are additions, some redefine things.
> 
> you are mistakeing the .config file for a symbol table.

No I'm not confusing. As long as the .config has an influence on the 
makefiles I get different symbols names.

> for example if you compile a kernel with SMP=y you get different code 
> then if you compile with SMP=n
> 
> if you have the same kernel version on identical machines, but with the 
> SMP option different on the two different machines you cannot use the 
> same module binary on both of them.

Of course, but It's cleare that machines with SMP are different from a 
simple mono-cpu.

It's not an issue talking about smp vs. not-smp. Let's talk about a 
machine: it's useless arguing about Cray while I'm talking about a 
simple environment.

Every kernel has always the distinction about smp. So it's not a big 
problem.

> you would have an ABI for that kernel image, compiled with those 
> options, and with that compiler. if you change any of those things then 
> your modules won't work (you have a different ABI

Of course, as I stated, it's a distro's care to use the same gcc and 
same switches....

> what you are missing is that nobody has any interest in supporting a 
> kernel ABI, even within a single kernel version. there are just too many 
> advantages to changeing fundamantal things in the kernel depending on 
> the config options.

An advantage is the total freedom about the code. Ok, I know. But as 
long as the kernel grows, in size and in its use, something more should 
be considered. ABI is a step forward companies and people like me in 
handling linux easily. API and data structure stability should be 
something in mind, since breaking compatibility from 2.6.8 to 2.6.8.1 
causes big troubles to anyone who's mantaining many machines. And if you 
are in big environments, you probably use modules which are not in 
vanilla, and will never be, like OpenAFS.

Finding a bug in the kernel source and patching it, must be a careful 
step, because if I have to mantain 100 machines, and I know that 
applying the patch will result in a broken kernel modules, I'm not happy 
with it. I must go manually on each machine, apply the patch, recompile 
the modules... Makes me think about NOT applying the patch.

> I don't know why the default location for the modules, but again you are 
> assuming that you CAN have a single vmlinuz-2.6 kernel file for all 
> machines of a given arch.
> 
> you can't.

I think we can. Freedom in developing source code is not necessarily 
stealing bricks from someone's feet :)

> there are just too many config options that change the internals of the 
> kernel (locking, function call formats, CPU type optmizations, etc) for 
> you to just have one.

Source compatibility is there. Now, you're talking about issues which 
are not your buisness: a binary distribution must take care of how the 
kernel it's compiled. As long as it uses the same gcc and switches, it's ok.

Practically, if suse has kernel-2.6.A and kernel-modules-2.6.A it knows 
how they're compiled, and they work everywhere. Of course, it has also 
kernel-2.6.A-SMP and its modules.

When 2.6.B is released, using ABI will just result in another 
compilation, creating the kernel with additions and patches, and 
distributing them. Modules .A should work on .B, like I do with OpenAFS, 
Every kernel update shouldn't break the magic :)

> but 2.6.11.7 is not nessasarily binary compatable with 2.6.11.7, let 
> alone something drasticly different (say 2.6.11.6)

Sure, because it's not designed to be so.

I just see advantages on ABI, and I think it's not bad talking about it...

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enigCEE4F1A8F151E555A102B67C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXp/m4LBKhYmYotsRAip/AJ9luhIGQxauYzb/T4bADa3Uu3gCUQCeM5qO
/h4KvFkpyEOxm3NujpuUA9s=
=mOiJ
-----END PGP SIGNATURE-----

--------------enigCEE4F1A8F151E555A102B67C--
