Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVFWOLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVFWOLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVFWOLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:11:40 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:60680 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262534AbVFWOLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:11:18 -0400
Message-ID: <42BAC304.2060802@slaphack.com>
Date: Thu, 23 Jun 2005 09:11:16 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com> <42B8F4BC.5060100@pobox.com> <42BA4F7E.6000402@namesys.com>
In-Reply-To: <42BA4F7E.6000402@namesys.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Jeff Garzik wrote:
> 
> 
>>We have to maintain said ugly code for decades.
> 
> 
> No you don't, I do.
> 
> 
>>>filesystem, but if so, it will have to do it much more slowly.  Take the
>>>good ideas -- things like plugins -- and make them at least look like
>>>incremental updates to the current VFS, and make them available to all
>>>filesystems.
>>
>>So, Reiser4 may eventually take over VFS and be the only Linux
>>
>>This is how all Linux development is done.
>>
>>The code evolves over time.
>>
>>You have just described the path ReiserFS needs to take, in order to
>>get this stuff into the kernel, in fact.
> 
> 
> You missed his point.  He is saying ext3 code should migrate towards
> becoming reiser4 plugins, and reiser4 should be merged now so that the
> migration can get started.

Sort of.

I think ext3 would be nice as a reiser4 plugin.  Not everyone will want
to reformat at once, but as the reiser4 code matures and proves itself
(even more than it already has), the ext3 people may find themselves
wanting some of the more generic optimizations.

But, I don't think that will realistically happen at all.

Instead, what will probably happen is that once Reiser4 is in the
mainstream kernel, it will become more popular and noticable.  Other
FSes will take note.  ext3 people may decide they want
file-as-directory, and vfat people may decide they want cryptocompress,
and so on.  In order to do this, they can work with Namesys to port
whatever feature they need at the time to the standard VFS.

Eventually, with all the features ported, we end up with a situation
where there may be no meaningful difference between a filesystem and a
low-level reiser4 plugin.

At that point, we both win.  ext3 will effectively be reiser4 plugins,
and reiser4 will replace VFS, but incrementally and sanely, without
breaking old filesystems or depriving them of features.  This is indeed
the way to evolve the code slowly over time.

This way also has the advantage of avoiding yet another, even more
vicious flamefest if all the reiser4 functionality had to be ported to
VFS all at once.  Can any of you honestly say that you would be more
willing to accept a brand-new, relatively unproven filesystem with tons
of changes to the VFS than without?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrrDBHgHNmZLgCUhAQJN/A/6A4SqpsunKmj6NOKxqyMxkLVdMjxSuusa
V9XZIL6K0dDsF1FmvxsSVnl3so8u93sRCkxrBs3WQs9JqsA3f8O5VUvsdfqas/Fb
ZO+ht5n0r1BVfm1WJHHmR9xGm+jL2TMwVlVrcrrnBQLthq+9efggn5r9BXkOUPgz
57VMh6sjB9ioigmc2Wf6BsMlbBJpCz7EB91pcIrNzHdFOEWyuHm9mAP6ui2sppfK
bGaDlZcU4BzNUM8beakMkFuy7JCTFQj/O7s3G42Tqpi/4Ol1Vk7F2tgPkpxB0lHm
b/hCmCPbTHheRsDhT7gSHOzWrwA5pwKlT5nO4EWGq7DxZo2dgoYsa/2fP32uYPIX
r3vUfygk7MR59DKMi4LLcDy2OzvrtbwTkzgOVrw82NCi5J5/pu/gIHH1aHzkXM6T
YRd6G39+wmhN0n/MP3WAT7o3rbH4nuPiG8ZyZQyVTII9YRaOGwNLSjJKe1p9JFHY
Y+6bqK3h7LQrX4MfTSIu8k3m0iIt806uHP3GlV+HHKx/N/4HSxt6ikikI3jURO4z
XBr23/Uo3YNK+IuxQtPw2mKcdqqKhFq5OBmLkVFIzJyuh8KR7cfnFdl7luCTjFGL
KjtgZ39SwtjOUWKWJslkcrNwESqplMTwAaB6GPHiJRKbilaCM9GXm/teI0ZRCl+o
gBD0AdEBA9s=
=NJM0
-----END PGP SIGNATURE-----
