Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277924AbRJNXsz>; Sun, 14 Oct 2001 19:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277927AbRJNXsp>; Sun, 14 Oct 2001 19:48:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33956 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277924AbRJNXs3>;
	Sun, 14 Oct 2001 19:48:29 -0400
Date: Sun, 14 Oct 2001 19:48:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Bernd Eckenfels <ecki@lina.inka.de>
cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
In-Reply-To: <E15suoi-0006JL-00@calista.inka.de>
Message-ID: <Pine.GSO.4.21.0110141942100.7054-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Bernd Eckenfels wrote:

> In article <20011014185908.P1074@niksula.cs.hut.fi> you wrote:
> >> mount --bind /home/luser /home/luser
> >> mount -o remount,noexec /home/luser
> 
> Thats nice! For example on Debian GNU/Linux one can mount /var with noexec
> with the exceptin of /var/lib/dpkg/info/* because it contains all those
> installation scripts. (Well actually, this design decision is not that nice,
> but at least one can work around with your vfs mount option idea.

Same problem as with replacing /etc/alternatives symlink farms with
bindings - no support in Hurd. Considering somewhat erm... omnivorous
attitude of Hurd folks that may change at some point, but for now it's
a no-go.

