Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283389AbRK2StF>; Thu, 29 Nov 2001 13:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283394AbRK2StA>; Thu, 29 Nov 2001 13:49:00 -0500
Received: from c1238376-a.parker1.co.home.com ([65.6.124.144]:53511 "HELO
	mail.ecnerwal.com") by vger.kernel.org with SMTP id <S283384AbRK2Spl>;
	Thu, 29 Nov 2001 13:45:41 -0500
Date: Thu, 29 Nov 2001 11:38:15 -0700 (MST)
From: Ron Lawrence <rlawrence@netraverse.com>
X-X-Sender: <rjlawre@monster.jayfay.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Peter Osterlund <petero2@telia.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: CDROM ioctl bug (fwd)
In-Reply-To: <20011129182745.O10601@suse.de>
Message-ID: <Pine.LNX.4.33.0111291128320.2330-100000@monster.jayfay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 29 Nov 2001, Douglas Gilbert wrote:

> Peter,
> That patch is flawed as Jens and I found out the hard way
> in the sg driver. The scsi_do_req() can lead to the pointer
> chain on the following assignment into q being invalid (in
> the worst case).
>
> The easy fix is to move the assignment into q _before_
> the call to scsi_do_req().
>
> Doug Gilbert

Douglas, Moving the assignment up did the trick. The responsiveness is
back to it's old self again.

Thanks.

Jens, will you take care of submitting this patch, so it can be fixed in
the mainline kernel, or do I need to do something? I'm happy to do
whatever it takes to get this in.

Ron Lawrence
rlawrence@NeTraverse.com


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BoCaU0yq8UBYK2oRAuENAKCWIZ2+ulSLsC7rG7+hjo2vy6UsYgCgsGIm
wRS6Pkb6G3mITKZ1aciMKtM=
=Z/Cy
-----END PGP SIGNATURE-----


