Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVJBSXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVJBSXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 14:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJBSXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 14:23:36 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:4286 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1751136AbVJBSXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 14:23:35 -0400
Message-ID: <434025B5.5010208@gorzow.mm.pl>
Date: Sun, 02 Oct 2005 20:23:49 +0200
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
User-Agent: Thunderbird 1.4 (X11/20050930)
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: linux-kernel@vger.kernel.org
Subject: [SOLVED?] Re: 2.6.13-rc2+ - problem with DHCP
References: <433EBBEC.4050203@gorzow.mm.pl> <433ECE42.2070400@trash.net> <433F0228.6000304@gorzow.mm.pl> <433F6FF3.1040706@trash.net>
In-Reply-To: <433F6FF3.1040706@trash.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patrick McHardy wrote:
| Radoslaw Szkodzinski wrote:

<snip>

| I can't reproduce the problem, it reliably works for me using pump,
| dhclient or udhcpc. One thing I've noticed is that udhcpc 0.98
| doesn't set the interface up itself and fails if it is down. Please
| make sure that it is up in your tests.
|
|> 2.6.13, 2.6.14-rc1 (up to the patch) both work fine.
|> 2.6.14-rc2 and 2.6.14-rc3 do not. (they can't discover IP address)
|> The window is between that commit and rc2.
|> (about 180 changesets)
|>
|> I only suspect that patch, it could be something else but I highly doubt
|> it. I'll check the current kernel with the patch backed out when I have
|> to restart.
|
| Thanks. You mentioned you're setting up your ruleset after DHCP, which
| means the patch can't be responsible because the codepath is never
| taken for DHCP queries, so you probably need to do a binary search
| over the remaining 180 changesets.

Which didn't work out. The bug disappeared... Probably my ISP messed
something up in their config and fixed it afterwards.
Really weird.
Before, I've tried 10 times each:
2.6.13 and changeset 8917 were getting IP address correctly, while
2.6.14-rc1 after the changeset not. Now all versions work fine.
Including 2.6.14-rc3.

- --
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDQCW1lUMEU9HxC6IRAg90AJ0SJwehNFeHJw40BJ/zaLyU/tY7yQCgjRaO
/U2kAFrHr1z8v+ep456ij0Y=
=jUlW
-----END PGP SIGNATURE-----
