Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUFYXsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUFYXsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUFYXsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:48:22 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:744 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266892AbUFYXsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:48:20 -0400
Message-ID: <40DCB9C2.5000605@comcast.net>
Date: Fri, 25 Jun 2004 19:48:18 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net>	<6uhdsz3jud.fsf@zork.zork.net> <20040625150021.3f50350b.akpm@osdl.org>
In-Reply-To: <20040625150021.3f50350b.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
| Sean Neakums <sneakums@zork.net> wrote:
|
|>I seem to remember somebody, I think maybe Andrew Morton, suggesting
|>that a no-journal mode be added to ext3 so that ext2 could be removed.
|>I can't find the message in question right now, though.
|
|
| I think it could be done, mainly as a kernel-space-saving exercise.  But
| the two filesystems are quite different nowadays.
|
| ext2 uses per-inode pagecache for directories, ext3 uses blockdev
| pagecache.  The truncate algorithms are significantly different. Other
stuff.
|

So why isn't it feasible to keep truncate algorithms and pagecache code
separated while collapsing the rest?  Same logic as i said in another reply:

if (journaled)
~  extfs_journaled_truncate();
else
~  extfs_nonjournaled_truncate();

| Much pain, little gain.

I understand this; but all work done is volunteer, so it'll only get
done if someone wants to do it :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3LnAhDd4aOud5P8RApugAJ45XGfdVGxVSEYsk/N55S4r5Qd+BACgi1vp
cgv421B9Yxc3EX/TUv/nm+M=
=bZBQ
-----END PGP SIGNATURE-----
