Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263357AbVFYHqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbVFYHqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 03:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbVFYHqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 03:46:46 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:31495 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263357AbVFYHqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 03:46:22 -0400
Message-ID: <42BD0BC5.3040906@slaphack.com>
Date: Sat, 25 Jun 2005 02:46:13 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Krogh <jesper@krogh.cc>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain> <42BCCC32.1090802@slaphack.com> <d9ipuc$gu$1@sea.gmane.org>
In-Reply-To: <d9ipuc$gu$1@sea.gmane.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jesper Krogh wrote:
> ["Followup-To:" header set to gmane.linux.kernel.]
> I gmane.linux.kernel, skrev David Masover:
> 
>>>Most desktop users today don't have backups because there is no credible
>>>backup technology for 500Gb of data. They may have partial backups. Some
>>
>> Bandwidth is getting faster.  And I just found a nice site for backups
>> called streamload.com.  They don't seem to support rsync, and allow only
>> 100 meg downloads, but unlimited uploads.
>>
>> Few desktop users today really need to backup more than 50 megs of data.
> 
> 
> That gives tedious manual work.. and btw, won't save you if you from
> loosing stuff from when the backup was made until now. 

Manual?

Try scripting.  For me, that's a tar command involving /home, /etc, and
about one or two other files, with a few excludes, like /home/shared/video.

>>>things the fs can't deal with - if the disk goes boom then thats a lower
>>>level concern. Also certain bits like writing to spare blocks on a
>>>problem write are indeed handled drive level nowdays.
>>
>> Right.  And putting them in the FS is unneccesary bloat if you've got
>> another mechanism for dealing with it.  Anyone with 500 gigs of data can
>> afford to do a little RAID, or at least some burned DVDs.
>>
>> DVDs are cheap nowdays:
>> http://www.newegg.com/Product/Product.asp?Item=N82E16817502002
> 
> 
> Again lots of manual work.. I actually have a DAT-station.. but I'm not
> getting it used. People have DVD-burners, but many don't get time to do
> a backup anyway. A Copy-On-Write feature in the filesystem would save
> the average dataloss situation todag (for home users). Where they
> accidentally deletes stuff. 

A lot of the people I know keep stuff on their DVDs, like movies and
music, so they can carry them around.  And the rest of it is the 50 megs.

>> Streamload.
> 
> 
> Why, when it could be quick and transparent. And Linux is used many
> places where you cant let data out-of-the-house of where bandwidth
> "sucks". The waste-space in my diskdrives increases everyday .. and i
> fill up with a tar-ball of the system every now-and-then, but it would
> definately be better suited and more effecient (save me more times) done
> directly in the filesystem. 

Streamload is quick and transparent for me.  I put files on the
fileserver, it tars them up and uploads them via Streamload's perl client.

>> I agree it's nice to have a more corruption-proof filesystem.
>> Convenient.  But not absolutely necessary.
> 
> 
> Thats called raid, we have that allready. But raid won't help for and: 
> rm /etc/passwd, a Copy-On-Write filesystem (not-snapshot) would. Used on
> a mirrored raiddisk, with enough space on the disk, it would actually
> guard you from allmost anything but getting the computer stolen. 
> 
> Totally unrelated to reiser4 but a feature that would be nice to have in
> "any" filesystem. 

Not totally unrelated.  COW has been discussed.  I don't remember if the
low-level stuff was done, but the main complaint was a lack of a copy
system call.

And RAID is an argument for Reiser4's attitude that it's not the job of
the FS to be corruption-proof.

Still, it's far easier to avoid deleting stuff than to avoid disk
failure.  First priority is to get the stuff OFF the machine.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr0LxXgHNmZLgCUhAQKKBBAAiAicaEKY42s0WctOcLg/m/ciVtphQ1jY
rChlThrsRCl4xAE45GgAu4P1ZdEYGwI1574W9z2j8EpbdnghX8tBHFUDSG1/K3+f
8Ud0zyMaI46k+D/IzkXS1ENYDj1PGmPAuVbM2pAa3JW0UOMzvKRsSADewxAW7OdY
V9fazSYu6l7Sn64XJxpZmXs9fkElXkqaNu/2N5d6rdH8hMmLhxs8HcsbAaJ7ch87
lz2RMruQ4Keh6H6HTHHvmoYog6XakwkD0pOY0efFZolO/EZFnmIlS9VHRIyb6mls
2xKPABDh9Qq0qQxpATgmXnVI9oh9qgrp4wqQ8nTQfEnhL5fvfBTXzJgfjOJiqXUy
vX4K/PP+9wzQNoqhTj4g11JBT8ilemsA4U+gbr82qSvvkOXrHkgGTQe6wgUyo6GZ
R8Ui7/jmAvNw+RvfL/p0s0s3e/EimUC7ASvN64z6z77wqNH0uUfUwRmD9SL8TbTf
jPdFvcd65F84T4gXphT4Dhwjs4fVjZUq3BqB+zMl3lKJP6pJfc5bqpjvqc2Rg1Yv
jfpvk3gihG7YN68IgZV+9IHJG6d5P05gi/YMqu75JDkqTXe2VznOXXQp4d58PhO0
ZKJnvAfr/xKrnuwgDUjgfaHThgquyMiC95hMo4IlSEfUquKPFGY4c9k0VKQHduqc
lcZOnfkvar0=
=olqO
-----END PGP SIGNATURE-----
