Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269484AbUICBMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269484AbUICBMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269478AbUICAtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:49:03 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:18331 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269480AbUICAoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:44:20 -0400
Date: Fri, 3 Sep 2004 02:44:07 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1862674154.20040903024407@tnonline.net>
To: David Masover <ninja@slaphack.com>
CC: viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4137B5F5.8000402@slaphack.com>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus>
 <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus>
 <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk>
 <4137B5F5.8000402@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1

> viro@parcelfarce.linux.theplanet.co.uk wrote:
> | On Thu, Sep 02, 2004 at 11:48:06PM +0200, Frank van Maarseveen wrote:
> |
|>>mount is nice for root, clumsy for user. And a rather complicated
|>>way of accessing data the kernel has knowledge about in the first
|>>place. For filesystem images, cd'ing into the file is the most
|>>obvious concept for file-as-a-dir IMHO.
> |
> |
> | The hell it is.
> |
> | a) kernel has *NO* *FUCKING* *KNOWLEDGE* of fs type contained on a device.

> reiser4 kernel will contain knowledge of fs type contained in a file.

> "file/..metas/type" might contain a mime type.  Mime type might have to
> be guessed, but at least if it's made by a local "mkisofs" then we're fine.

> Indeed, that's not the only interface that's been discussed.
> "file/..metas/is_isofs" might be consulted.

 What you are talking about isn't the kernel or such, but plugins that
 could extend the filesystem. Plugins could store information about
 contents, encodings, formatting, filesystems, etc, as meta-info. If
 you have a plugin that would allow you to traverse files as disk
 images then it could read those meta-data. But before those plugins
 exist then there is no such standard for info stored as meta-data and
 the kernel wouldn't know anything about this to begin with.


> | b) kernel has no way to guess which options to use
> | c) fs _type_ is a fundamental part of mount - device(s) (if any) involved
> | are arguments to be interpreted by that particular fs driver.

> Unless there's some severe security issues with "mount this iso as fat
> and you get root access", this should work fine.

> I see no reason why there can't be a global setting of the mount
> commandline to use.

> And it doesn't all have to be in the kernel.  Only it'd be nice to have
> some of it there because the kernel knows how to deal with an isofs,
> even if it won't know what it looks like.

> | d) permissions required for that lovely operation (and questions like
> | whether we force nosuid/noexec, etc.) are nightmare to define.

> They are quite simple, actually.  Just set them globally -- some admins
> would force nosetuid/noexec, some wouldn't.  And the operation happens
> transparently -- you need no "permissions" other than to read the
> directory which would contain the mount.

> | Frankly, the longer that thread grows, the more obvious it becomes that
> | file-as-a-dir is a solution in search of problem.  Desperate search, at
> | that.

> Actually, the longer this thread grows, the more obvious it is how when
> there's a hot issue, everyone has an opinion, even if the same opinion
> has been expressed ten or twenty times already.

> File-as-a-dir has numerous advantages, but enough have been discussed.
> Short list is image mounts, tarballs, streams, metas, and namespace
> unification.  Longer list and explanations can be found if you RTFA.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

> iQIVAwUBQTe19XgHNmZLgCUhAQJdow/+Knsw1GgpauqDUcg8sKtxzgXZ18OxMQ3Q
> By8sRrSTuKAzI5A3BtYIzndsj1veP+7wndG7nYPz8NS1fU2+xWSIhoGq/YMaQsu4
> 70uMLu448PFXZua4hZMk2w4mkULXbGyYHJ1Bf+2Z7QkQ/8W08hozC8QQynxMXIkX
> SrcWCS5hK8Nh7Ol691sDpPqexH7F1GwUyoslNGj63U5r6ViLAawt2ZKDYdT7ZPo8
> 0a/pWUHoHMPbv/KwqZZxRr1/qncA9QYQo6JqQBPPCr+tWNJs/ei3nAKGi58iOt1M
> DK1TEKd2lpbmwiK5pWDwGz+nwWmaFTAyfTEEEcP4gZedSJtRXaxyNh0jRl1iLATB
> SCO5Eb4jkQs8hdjHqQcQ1q7XKFX9eSXWeDdrGrtWaYC/QYOHxT+ci3lnKBKCG99Y
> YTqg3sNEZlV1N0jIcNvFSDEYbbX12v1Y6xbwvUx48+sMyUj3suT76niTRbwEydfO
> MA9y+wE2k4wF+h+sJCbTjimCNFvvuFTTJuBCbQTpfY4eOYBAFalxnWmrpTEfVzka
> 4iAqAYygWObGDkFFy/rp1HEVZPIKM0NwGLOsRwJsgyUMOsccBrEc0bg8sgMECVfs
> 5qNIb27tLokh8NBR6RodAv2NZYKC+foM0T+PC5bZMFD/Q7f6yDklqK4C4RCIYaXj
> xO9z1C6FPcM=
> =/gmK
> -----END PGP SIGNATURE-----

