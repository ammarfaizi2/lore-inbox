Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283331AbRK2RZl>; Thu, 29 Nov 2001 12:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283339AbRK2RZc>; Thu, 29 Nov 2001 12:25:32 -0500
Received: from c1238376-a.parker1.co.home.com ([65.6.124.144]:48903 "HELO
	mail.ecnerwal.com") by vger.kernel.org with SMTP id <S283331AbRK2RZU> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 12:25:20 -0500
Date: Thu, 29 Nov 2001 10:17:55 -0700 (MST)
From: Ron Lawrence <rlawrence@netraverse.com>
X-X-Sender: <rjlawre@monster.jayfay.com>
To: Peter Osterlund <petero2@telia.com>
Cc: <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: CDROM ioctl bug (fwd)
In-Reply-To: <m2elmi1mjx.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.33.0111291006290.1704-100000@monster.jayfay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29 Nov 2001, Peter Osterlund wrote:
>Ron Lawrence <rlawrence@netraverse.com> writes:
>> busy. Here are the symptoms of my problem : doing reads from a CDROM
>> device intermingled with CDROM_MEDIA_CHANGED ioctls causes long pauses
>> during the ioctl. This behavior started in 2.4.10. The ioctl can take a
>> very long time to return, especially if reading large chunks.
>This patch fixes the problem for my USB CDROM device. Maybe a similar
>patch is needed for the IDE case, I haven't looked yet.

Thanks! I should have mentioned that it affects CDROM drives when accessed
via ide-scsi, but not when accessed "normally" via ide.  So, your patch
helps this case too. It is still significantly slower than "normal"
access, and I will run some tests to see if it's still slower in this case
than it was in 2.4.9.

>In general, who is responsible for unplugging the request queue after
>queuing an ioctl command?
>
>Peter Österlund             petero2@telia.com
>Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
>S-128 66 Sköndal            +46 8 942647
>Sweden

Ron Lawrence
rlawrence@NeTraverse.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Bm3GU0yq8UBYK2oRAsH/AJ9fy5LQSTiES5PD0BczAb82EXrsYgCaA3sI
zeX3IuZnQzh7B80TT4oJH4M=
=+UKy
-----END PGP SIGNATURE-----


