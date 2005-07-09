Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVGIW7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVGIW7U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 18:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVGIW7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 18:59:20 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:45230 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S261726AbVGIW7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 18:59:19 -0400
Date: Sat, 9 Jul 2005 15:59:39 -0700 (PDT)
From: Eric Sandall <eric@sandall.us>
X-X-Sender: sandalle@cerberus
To: Wakko Warner <wakko@animx.eu.org>
cc: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
In-Reply-To: <20050708224106.GA10649@animx.eu.org>
Message-ID: <Pine.LNX.4.63.0507091559030.486@cerberus>
References: <E1DqhZV-0004yW-00@calista.eckenfels.6bone.ka-ip.net>
 <1120836958.16935.1.camel@localhost> <20050708224106.GA10649@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 8 Jul 2005, Wakko Warner wrote:
> Jeremy Nickurak wrote:
>> On ven, 2005-07-08 at 03:22 +0200, Bernd Eckenfels wrote:
>>> No, it is creating files by appending just like any other file write. One
>>> could think about a call to create unfragmented files however since this is
>>> not always working best is to create those files young or defragment them
>>> before usage.
>>
>> Except that this defeats one of the biggest advantages a swap file has
>> over a swap partition: the ability to easilly reconfigure the amount of
>> hd space reserved for swap.
>
> Of course, now this begs the question: Is it possible to create a large file
> w/o actually writing that much to the device (ie uninitialized).  There's
> absolutely no reason that a swap file needs to be fully initialized, only
> part which mkswap does.  Of course, I would expect that ONLY root beable to
> do this. (or capsysadmin or whatever the caps are)

That would make the swap file fragment as it's used, instead of
allocating one big file (the entire file) at once (and hopefully get
one contiguous chunk of the disk).

- -sandalle

- --
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC0FbfHXt9dKjv3WERApKjAJ9ZObnrYWCmTyZW0ChggtgGjTKIvQCfbnvm
/U4zfjTYqMxEd5vmIRe1wbM=
=smCj
-----END PGP SIGNATURE-----
