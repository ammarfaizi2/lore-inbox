Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSGQUmu>; Wed, 17 Jul 2002 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGQUmu>; Wed, 17 Jul 2002 16:42:50 -0400
Received: from [217.9.63.109] ([217.9.63.109]:58106 "EHLO
	NCC-1701.B.Shuttle.de") by vger.kernel.org with ESMTP
	id <S316715AbSGQUms>; Wed, 17 Jul 2002 16:42:48 -0400
Date: Wed, 17 Jul 2002 22:44:38 +0200 (CEST)
From: Manfred Wassmann <debian-devel@NCC-1701.B.Shuttle.de>
Reply-To: debian-devel@lists.debian.org
To: Debian Development <debian-devel@lists.debian.org>
cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       miquels@cistron.nl, Michael Meskes <Michael.Meskes@credativ.de>
Subject: Re: Minor bug (?) in mountpoint handling in 2.4.18
In-Reply-To: <20020717134018.GA18869@feivel.credativ.de>
Message-ID: <Pine.LNX.4.21.0207172238540.4268-100000@figaro.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Michael Meskes wrote:

> fs/namespace::do_add_mount() says:
> 
> ...
> /* Refuse the same filesystem on the same mount point */
> ...

[...]

> I'm not sure if this really is a bug as technically it does not create a
> problem, but I know a lot of users who are pretty confused.

In fact it does create problems.  If you have an entry for a nfs mount in
/etc/fstab allowing it to be mounted by ordinary users using th user
mount option, it is no longer possible for such an user to unmount the
corresponding file system once it is mounted multiple times.  Instead the
following error message is returned:
  umount: it seems /var/www/VTX is mounted multiple times

> P.S.: Please CC me on replies.

ACK 



