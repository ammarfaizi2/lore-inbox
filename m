Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUC2OnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 09:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUC2OnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 09:43:16 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:21987 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262900AbUC2OnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 09:43:10 -0500
Date: Mon, 29 Mar 2004 15:42:37 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Arjan van de Ven <arjanv@redhat.com>
cc: tigran@aivazian.fsnet.co.uk, Marco Baan <marco@freebsd.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: failure to mount root fs
In-Reply-To: <1080561608.3570.2.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0403291537310.24736@student.dei.uc.pt>
References: <26889266.1080559781017.JavaMail.www@wwinf3002>
 <1080561608.3570.2.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 29 Mar 2004, Arjan van de Ven wrote:

> On Mon, 2004-03-29 at 13:29, tigran@aivazian.fsnet.co.uk wrote:
> > Hi Macro,
> >
> > You wrote:
> >
> > > VFS: Unable to mount root fs on unknown-block(0,0)
> > > ...
> > > kernel /boot/bzImage-2.6.4 ro root=LABEL=/
> >
> > The "LABEL=/" is the attempt to mount root filesystem by label, so you can
> > move it to another disk. I find these "clever" things not mature yet and always replace it by an explicit device name (and don't move/replace root disk):
>
> it's ok as long as you remember to make an initrd (make install in the
> kernel source will do so automatic, at least on a RH/Fedora system)

It doesn't solve the problem, I have the same issue... And seeing kerneltrap
forums, we're not the only ones.
I fixed that problem by changing .config (it seems that oldconfig messed it) to
show:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y

Now I don't get the
VFS: Unable to mount root fs on unknown-block(0,0)

but when booting, it shows:
VFS: Mounted root (ext3 filesystem) readonly.

and then just freezes.

Any thoughts on this?
(if needed, my config is in http://student.dei.uc.pt/~marado/.config )

Best regards,
Mind Booster Noori


- -- 
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFAaDXgmNlq8m+oD34RAtjvAKD2c2CxntbDwIyTdlLbxcKpYCDmVwCg3Vzt
18I2v/gWkGYpr1qPlFsSCmA=
=B7uM
-----END PGP SIGNATURE-----

