Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUJXRlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUJXRlB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUJXRlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:41:01 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:39559 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S261548AbUJXRkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:40:49 -0400
Message-ID: <417C0520.8020807@slaphack.com>
Date: Sun, 24 Oct 2004 14:40:16 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.9-mm1
References: <20041023165712.GR26192@nysv.org> <417B1574.4090406@slaphack.com> <417B3A34.2060306@namesys.com>
In-Reply-To: <417B3A34.2060306@namesys.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
| David Masover wrote:
|
|>
|> Some people don't care about speed but need space.  I'd leave them in on
|> general principle, even if no one wants them now.
|
|
| Software design is usually improved by identifying features that aren't
| worth much, and removing them from the interface and burying them where
| average users don't see them (or dumping them completely).  Interface
| clutter has a cost.

Clutter, yes.  A tree-like structure can help things, and menuconfig
allows that.

That said, I don't object to hiding it in a header file, but I can
easily imagine a situation where someone would want small keys -- a very
small filesystem (flash ROM) with lots of metadata stored in a rather
deep tree without much fanout (am I using these terms properly?).  I
doubt much speed is gained by having large keys in such a situation, but
for storage space, every byte counts.

Now, the reiser4 code seems quite large compared to the space saved, but
suppose the user had chosen it already for other reasons (metadata,
space saved with cryptocompress plugin).  If reiser4 was going to be
used for any storage at all in such a situation, the user would much
rather use it for all storage than write a storage layer on top of it.
The inclusion of a (even stripped down) libdb might be the proverbial
straw that broke the camel's back.

It's possible that we will never see such a situation, but embedded
Linux is quite popular these days.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQXwFIHgHNmZLgCUhAQLYVg//RgYgH7Qcc9Q6GfoCAn8BtvvOnF70BkM3
3kD7334ubSIeOxVadJxNWptakjhTlXzqzm19BaQoyVajOrHKLd4rj4zHVxKdYdXf
EA2QCmCyPWd4MtiteVxSjJq/zO9Vfbx62pJ2aV+HyjfRf2g+sznMmBhrXcCV3/ti
1xWBM43yl/6vhJOVWNgkl4V3vmALsaE6xp7ZXSagvllEEm+axgD5Uu2elrccBPgh
KhjYMhqqWmfvdrdgfkShfjrd2zAOqN9823Cc85QBeGWMDJ6r23bcR7fBU7eMv4rL
o5XcUcG230G6QKMRoiYlS3usn53G+h43e4MVxWoHdOriS9wYgF3S9lHTMSZvy43z
dTpDcI4+SjQfQs8GkI6LP7Oktz6RQbBO/ufVf/EwTKphIljdxtnUPqOFPYBAiKpU
OzQULqj+ehMxszhyjFA/6wavBtTGkl8ntnUWcYkCN50i2towWfKVVsbgZKHunEvv
p5TgeEpEax6kCWbvbTc+4/xUBYBT3RKJAPIIH1LzrakqFItm5VOQ+cTANfOQmVwJ
Q5E7WPtxxc5wLMYXnhPH5bCCr1LTXuyUBL6nBRVDE5zdiftlnhdL+PGZlfLY/7RO
GeOkGwtg2tnDGVwBXHKPo9Ev93QPcDwzYWjMzCKPAk4XeeEg0GgHGiot/gkOXWTH
bghEu/Vr3FI=
=dP28
-----END PGP SIGNATURE-----
