Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbRF0Lzg>; Wed, 27 Jun 2001 07:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbRF0Lz0>; Wed, 27 Jun 2001 07:55:26 -0400
Received: from mail.fbab.net ([212.75.83.8]:19972 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S264934AbRF0LzQ>;
	Wed, 27 Jun 2001 07:55:16 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: viro@math.psu.edu linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 8.063695 secs)
Message-ID: <008001c0ff00$448873d0$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0106270422400.19655-100000@weyl.math.psu.edu>
Subject: Re: Maximum mountpoints + chrooted login
Date: Wed, 27 Jun 2001 13:56:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alexander Viro" <viro@math.psu.edu>
>
[snip]
>
> I didn't go for proper solution in 2.4.0-test*). However, instead of
> crufting up kinda-sorta namespaces one could use the real thing. Relevant
> cleanups of superblock handling will go in in 2.5.very_early and the
> rest of patch (namespace proper) takes about 10Kb.
>

I'll wait for 2.5 then...
Where's that namespace patch located?

> You can simply say clone(CLONE_NAMESPACE,NULL) and you get an independent
> set of mounts to play with. mount/umount whatever you want before dropping
> the root priveleges. All children of that process will share its
namespace.
> When the last one goes away everything will be garbage-collected - no
> need to umount anything on logout.
>

Lovely!

>
> With the mntcache in - not really. It fixes the main performance problem.

Now in 2.4.5 it's darn slow to _unmount_, it's like 100 times faster to
mount than unmount :)

Cheers

Magnus Naeslund

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



