Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbTJRTeD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTJRTeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:34:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:24779 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261791AbTJRTd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:33:59 -0400
Date: Sat, 18 Oct 2003 21:33:58 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031018192517.GD7665@parcelfarce.linux.theplanet.co.uk>
Subject: Re: initrd and 2.6.0-test8
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <14123.1066505638@www30.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 18, 2003 at 09:10:04PM +0200, Svetoslav Slavtchev wrote:
> > me had  the same problems,
> > with devfs enabled
> > 
> > could it be this (from Documentation/initrd)
> > 
> > Note that changing the root directory does not involve unmounting it.
> >     the "normal" root file system is mounted. initrd data can be read
> >   root=/dev/ram0   (without devfs)
> >   root=/dev/rd/0   (with devfs)
> >     initrd is mounted as root, and the normal boot procedure is
> followed,
> >     with the RAM disk still mounted as root.
> > 
> > the patch doesn't mention anything about /dev/rd/0 , but does for
> /dev/ram0
> 
> *Arrgh*
> 
> Presense of devfs is, indeed, the problem.  /dev/rd/0 vs. /dev/ram0 is not
> an issue; visibility of /dev/initrd, OTOH, is - we have /dev of rootfs
> overmounted by devfs, so the thing becomes inaccessible.
> 
> OK, that's trivially fixable.  We need to put the sucker outside of /dev,
> that's all.  Patch in a few...

:-)

waiting a few... for a patch to test 

svetljo

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

