Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270624AbTGURGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270630AbTGURFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:05:41 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:62897 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S270625AbTGURF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:05:26 -0400
Date: Mon, 21 Jul 2003 13:12:32 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: 2.6.0-test1 cryptoloop & aes & xfs
In-reply-to: <20030720213803.GA777@jolla>
To: Hielke Christian Braun <hcb@unco.de>, linux-kernel@vger.kernel.org
Message-id: <200307211312.40068.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <20030720005726.GA735@jolla>
 <20030720103852.A11298@pclin040.win.tue.nl> <20030720213803.GA777@jolla>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 20 July 2003 17:38, Hielke Christian Braun wrote:
> Thanks for the tip. With util-linux-2.12 i can setup the device.
>
> So the new cryptoloop in 2.6.0 is incompatible to the one in the
> international crypto patch?
>
> I could not access my old data. So i created a new one. But when
> i copy some data onto it, i get:
>
> XFS mounting filesystem loop5
> Ending clean XFS mount for filesystem: loop5
> xfs_force_shutdown(loop5,0x8) called from line 1070 of file
> fs/xfs/xfs_trans.c. Return address = 0xc02071ab Filesystem "loop5":
> Corruption of in-memory data detected. Shutting down filesystem: loop5
> Please umount the filesystem, and rectify the problem(s)
>
> To setup, i did this:
>
> losetup -e aes /dev/loop5 /dev/hda4
> mkfs.xfs /dev/hda4

No, you should use

mkfs.xfs /dev/loop5

you want to create a fs on the loop device.

Jeff.

- -- 
bad pun of the week: the formula 1 control computer suffered from a race 
condition
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HB8EwFP0+seVj/4RAn6DAJ9pqcYxLq2mee/RaFCBdtr3YvorlgCgkubm
IY3V6WaA0K3xNnIqL0yNIQU=
=2FAW
-----END PGP SIGNATURE-----

