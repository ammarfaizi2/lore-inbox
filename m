Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUAWIWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUAWIWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 03:22:38 -0500
Received: from b071088.adsl.hansenet.de ([62.109.71.88]:60353 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S266538AbUAWIWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 03:22:33 -0500
Message-ID: <4010D9C1.50508@portrix.net>
Date: Fri, 23 Jan 2004 09:22:25 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org>
In-Reply-To: <20040119153005.GA9261@thunk.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF03E58B382EB436E82DB633C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF03E58B382EB436E82DB633C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Theodore Ts'o wrote:
> On Sun, Jan 18, 2004 at 10:02:32AM -0800, Mike Fedyk wrote:
> 
>>On Sun, Jan 18, 2004 at 11:27:54AM +0100, Jan Dittmer wrote:
>>
>>>EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory 
>>>#9783034: rec_len % 4 != 0 - offset=0, inode=1846971784, rec_len=33046, 
>>>name_len=154
>>>Aborting journal on device dm-1.
>>>ext3_abort called.
>>>EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted journal
>>>Remounting filesystem read-only
>>
>>Run fsck on the filesystem.
> 
> 
> Jan, what distribution are you running?  The superblock *should* have
> been marked "filesystems has errors", and so fsck should have been
> forced when you rebooted.  Did fsck in fact run, and if so, did it
> detect and fix any problems?
> 
> 						- Ted

Okay, I fscked all filesystems in single user mode, thereby fscked up my 
root filesystem, though I didn't even check it - so I restored it from 
backup (grub wouldn't even load anymore).
After 2 days in my freshly setup debian (2.6.1-bk6), same error. But 
this time at least I know it's because I tried to delete those files in 
the lost+found directory...
So, how do I delete these and why did fsck fail? It's pretty annoying to 
reboot because of this. It would be nice to just being able to 
remount,rw the partition.

Thanks,

Jan

EXT3-fs error (device dm-2): ext3_readdir: directory #16370 contains a 
hole at offset 8192
Aborting journal on device dm-2.
EXT3-fs error (device dm-2): ext3_readdir: directory #16370 contains a 
hole at offset 24576
ext3_abort called.
EXT3-fs abort (device dm-2): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only

--------------enigF03E58B382EB436E82DB633C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAENnFLqMJRclVKIYRAnbYAJ9Lj6DlNcHhq6uJrdUTM/34lMNazACfaMNR
o4VBQ/s2Gr68PG/28TDEWK4=
=L383
-----END PGP SIGNATURE-----

--------------enigF03E58B382EB436E82DB633C--
