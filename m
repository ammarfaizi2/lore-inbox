Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWDOKa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWDOKa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 06:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWDOKa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 06:30:57 -0400
Received: from mx1.mail.ru ([194.67.23.121]:51799 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932480AbWDOKa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 06:30:57 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Which device did I boot from?
Date: Sat, 15 Apr 2006 14:30:40 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
References: <200604151059.47733.arvidjaar@mail.ru> <4440C03F.4080709@keyaccess.nl>
In-Reply-To: <4440C03F.4080709@keyaccess.nl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604151430.43099.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 15 April 2006 13:43, Rene Herman wrote:
> Andrey Borzenkov wrote:
> >> If you choose the (experimental) CONFIG_EDD option in your kernel then,
> >> with cooperation of your BIOS, you'll have a /sys/firmware/edd with at
> >> least some info about the BIOS boot device. For me:
> >
> > I am sorry but it does not tell about boot device. It contains all hard
> > disks enumerated via EDD interface. I do not see any information
> > under /sys/firmware/edd that would have allowed to guess boot device.
>
> int13_dev80 is the bootdevice. Or that used to be the case with things
> such as booting from SCSI at least. Don't know about booting from, say,
> USB.
>

OK. In this case udev creates links based on MBR signature; it can be used to 
infer real device:

{pts/0}% LC_ALL=C ll /dev/disk/by-id
lrwxrwxrwx  1 root root  9 Apr 12 21:36 edd-int13_dev80 -> ../../hda
lrwxrwxrwx  1 root root 10 Apr 12 21:36 edd-int13_dev80-part1 -> ../../hda1
lrwxrwxrwx  1 root root 10 Apr 12 21:36 edd-int13_dev80-part2 -> ../../hda2

Not sure about USB either.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEQMtSR6LMutpd94wRAsFkAJsFOkTxa9DWphkiZ/eomAKl6rbHMgCeIlZL
DkkNhTvgK0USRRyiMeqdtLY=
=yCYm
-----END PGP SIGNATURE-----
