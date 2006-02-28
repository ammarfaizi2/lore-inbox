Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWB1MHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWB1MHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWB1MHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:07:09 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:485 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932392AbWB1MHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:07:08 -0500
Message-ID: <44043CDE.6040204@comcast.net>
Date: Tue, 28 Feb 2006 07:06:54 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory compression (again). . help?
References: <4403A14D.4050303@comcast.net> <4403C30A.6070704@comcast.net> <aec7e5c30602272120l54a3e8c9k2db51a1c86823f7b@mail.gmail.com>
In-Reply-To: <aec7e5c30602272120l54a3e8c9k2db51a1c86823f7b@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Magnus Damm wrote:
> On 2/28/06, John Richard Moser <nigelenki@comcast.net> wrote:
>> Hmm, I can't see where the kernel checks to see which pages are least
>> used. . . . anyone good with the VM can point me in the right direction?
> 
> The page reclaim code responsible for shrinking the LRUs code be found
> in mm/vmscan.c. That file contains a lot of code, my recommendation to
> you is to have a look at shrink_zone() which is responsible for
> rotating and shrinking the active and inactive lists.
> 

Thanks, I'll take a look.

> Also, If you want to compress pages that normally would be swapped
> out, then I recommend you to have a look at the functions in
> mm/swap_state.c and see how swap space gets allocated and freed.
> 

Mm.  Ok.

> If you need to know more about the Linux VM then I recommend you to
> buy the excellent book "Understanding the Linux Virtual Memory
> Manager" written by Mel Gorman, ISBN 0-13-145348-3. My copy of that
> book covers Linux-2.4 and has some comments about 2.6 too.
> 

I'll shoot from the hip, my foot grows back.

> / magnus
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBDzdhDd4aOud5P8RApCXAKCASRwqJqXD/8rHh84x3tzkntC6jQCeMeqS
9B7IgG3aCEJOOXrOsxSMp3o=
=ZLh3
-----END PGP SIGNATURE-----
