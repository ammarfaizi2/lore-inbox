Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268125AbUHKRee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268125AbUHKRee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268133AbUHKRee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:34:34 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:29128 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S268125AbUHKRe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:34:29 -0400
Date: Wed, 11 Aug 2004 13:34:25 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
cc: "Steven E. Woolard" <tuxq@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: VFAT/MSDOS
In-Reply-To: <200408100027.55463.rjwysocki@sisk.pl>
Message-ID: <Pine.LNX.4.58.0408111333001.32568@vivaldi.madbase.net>
References: <11497362.1092087656059.JavaMail.root@ernie.psp.pas.earthlink.net>
 <11497362.1092087656059.JavaMail.root@ernie.psp.pas.earthlink.net>
 <200408100027.55463.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, R. J. Wysocki wrote:
> On Monday 09 of August 2004 23:40, Steven E. Woolard wrote:
> > VER: 2.6.8-rc3
> > Using a FAT16 file system mounted via /dev/sda1
> > it cannot be written to. When attempt is made it gives the error of being a
> > read-only file system.
>
> It's known.  It appears that you have to mount the fs with _both_ the
> "iocharset" _and_ "codepage" options explicitly specified to be able to write
> to it.  Alternatively, you can remount it with "rw" explicitly specified (as
> root).
>
> I hope that someone's working on a fix. ;-)

That change was reversed in 2.6.8-rc4:

> <torvalds@ppc970.osdl.org>
>     Revert FAT NLS changes.
>
>     It's causing massive user confusion, and breaks installers by
>     mounting the filesystem read-only.

Hooray for Linus!

Eric
