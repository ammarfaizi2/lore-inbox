Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbRF0Oq7>; Wed, 27 Jun 2001 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRF0Oqt>; Wed, 27 Jun 2001 10:46:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28151 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262684AbRF0Oql>;
	Wed, 27 Jun 2001 10:46:41 -0400
Date: Wed, 27 Jun 2001 10:46:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Magnus Naeslund(f)" <mag@fbab.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Maximum mountpoints + chrooted login
In-Reply-To: <008001c0ff00$448873d0$020a0a0a@totalmef>
Message-ID: <Pine.GSO.4.21.0106271038090.19655-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Magnus Naeslund(f) wrote:

> I'll wait for 2.5 then...
> Where's that namespace patch located?

The last one I've put on anonftp was against 2.4.6-pre2 (namespaces-a-S6-pre2,
on ftp.math.psu.edu/pub/viro). It still includes tons of fs/super.c cleanups
and fixes - they still need to be merged into the tree.

> Now in 2.4.5 it's darn slow to _unmount_, it's like 100 times faster to
> mount than unmount :)

Erm... The last umount should sync everything on given fs. You don't
read a hundred megabytes upon mount but you can easily get such amount
of dirty data after working for a while ;-)

