Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316083AbSEOO2O>; Wed, 15 May 2002 10:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316084AbSEOO2N>; Wed, 15 May 2002 10:28:13 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:59482 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S316083AbSEOO2M>;
	Wed, 15 May 2002 10:28:12 -0400
Date: Wed, 15 May 2002 15:28:17 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Dead2 <dead2@circlestorm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Initrd or Cdrom as root
In-Reply-To: <00bd01c1fc16$6fcfbd50$0d01a8c0@studio2pw0bzm4>
Message-ID: <Pine.LNX.4.33.0205151523500.2461-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Dead2 wrote:
> So, I now have a new problem I hope someone can help me out with.
> It now mounts the cdrom as root like it should, but then gives me the error:
> "Warning: unable to open an initial console."
>
> I have checked everything I can think of, but if someone could point me to
> exactly generates this error, I would be forever grateful.

Yes, that is well-known.

Unix root filesystem cannot be readonly in its entirety. Linux is much
better, but even Linux is not perfect.

So, what I do is --- I prepare the /var, /home, /etc, /dev in a tar.gz
file and place it on CD. Then, from rc.sysinit I mount tmpfs on those
points and unpack the tar.gz from / --- thus ending up with readwrite /var
/home /etc and /dev. (you could avoid /dev issue by using devfs but then
you will have other little problems to deal with :)

Btw, you will encounter lots of other problems, of course. Making a Linux
distribution is fun (I enjoy it) but it is not as trivial as some think.
It is certainly not a "pile of rpms" and Red Hat certainly do _not_ "just
package some free software" and sell it. Even without going into the level
of producing _general purpose_ distribution (which is what Red Hat Linux
is), making a (even specialized) Linux distribution is non-trivial. But it
is fun, try it :)

Regards
Tigran

