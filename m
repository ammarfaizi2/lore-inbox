Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUIQKaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUIQKaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIQKaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:30:39 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:4563 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S268674AbUIQKaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:30:35 -0400
From: Michael Scondo <michael.scondo@arcor.de>
Reply-To: michael.scondo@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Re: vfat bug - solved
Date: Fri, 17 Sep 2004 12:30:07 +0200
User-Agent: KMail/1.7
References: <200409170013.20712.michael.scondo@arcor.de> <20040917020405.GB2573@MAIL.13thfloor.at>
In-Reply-To: <20040917020405.GB2573@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409171230.07524.michael.scondo@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 17. September 2004 04:04 schrieb Herbert Poetzl:
> On Fri, Sep 17, 2004 at 12:13:20AM +0200, Michael Scondo wrote:
> > Hello..
> > I've just compiled a new kernel ( 2.6.8.1 ), and now I'm not able to
> > mount my fat32 partitions anymore.
> >
> > mount /dev/hda7 /mnt
> > mount: wrong fs type, bad option, bad superblock on /dev/hda7,
> >        or too many mounted file systems
> >
> > :-(
> >
> > Every works still fine with 2.6.4, but I'm not sure, whether this occurs
> > due to a bug in the kernel or because a wrong build process.
> > Therefore I'm posting this to the list.
>
> check the kernel ring buffer (dmesg) for codepages which
> are requested but not found (or other strange messages)
> which appear when you 'try' to mount the filesystem
>
> HTH,
> Herbert

Yes, the module fat wasn´t able to find cp437 as well as the charset 
iso8859-1. ( both configured as default )
If I pass the options "-o codepage=850,iocharset=iso8859-15" to mount, 
everything works fine.
Maybe, I should have been a little bit more watchful while configuring.
But weren't it sensible to provide a mechanism, which prevent's such a silly 
configuration ?

Thanks a lot 
Micha



