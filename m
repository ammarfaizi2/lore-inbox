Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUIKN7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUIKN7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIKN7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:59:10 -0400
Received: from dev.tequila.jp ([128.121.50.153]:27665 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268148AbUIKN7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:59:03 -0400
Message-ID: <414304A3.7080100@tequila.co.jp>
Date: Sat, 11 Sep 2004 22:58:59 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040830 Thunderbird/0.7.3 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
References: <20040908123524.GZ390@unthought.net>
In-Reply-To: <20040908123524.GZ390@unthought.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Jakob Oestergaard wrote:

| <frustrated_admin mode="on">
|
| Does anyone actually use XFS for serious file-serving?  (yes, I run it
| on my desktop at home and I don't have problems there - such reports are
| not really relevant).

I have our fileserver running completly on XFS (because its quota &
journaled).

I have an internal 60GB HW RAID 1 and an external 4 disk SCSI 400GB
software RAID 5 both running XFS. The Server is NFS, Samba and Appletalk
(thought that is almost not used). NFS is not the main point (except the
servers for sharing a backup disk and two office PCs who run linux there
is no NFS traffic, the rest ~50 PCs connect via Samba). It's Xeon single
CPU box, but I have an SMP kernel because of HT. 2GB ram.

I haven't had a single XFS connected error. It surved 5 hard reboots
because of another external disk that got berserk and forced me to turn
on/off the server.

A nightly backup on another HD on the same box goes well, even from 4
other servers via NFS.

| Is anyone actually maintaining/bugfixing XFS?  Yes, I know the
| MAINTAINERS file, but I am a little bit confused here - seeing that
| trivial-to-trigger bugs that crash the system and have simple fixes,
| have not been fixed in current mainline kernels.

well there is the linux-xfs ML ... :)

| If XFS is a no-go because of lack of support, is there any realistic
| alternatives under Linux (taking our need for quota into account) ?

lack of support. in my opinion there work some very bright persons. Main
problem is, that it comes from a system which is completly different
designed than linux and I think this problem still triggers those SMP,
etc bugs.

| And finally, if Linux is simply a no-go for high performance file
| serving, what other suggestions might people have?  NetApp?

Well. I am not yet in the TB leage and 200+ user boxes, etc. So I can't
say about that. But that will come soon, and then I will see if I have
to runt about that.

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBQwSjjBz/yQjBxz8RAg3nAKCOsh6TieGXgmutX/sbge4JvvKLMgCgghfg
IWo7h1QIZhGUOv0FH51FOVE=
=76lm
-----END PGP SIGNATURE-----
