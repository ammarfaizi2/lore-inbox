Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWDIVzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWDIVzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWDIVzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:55:52 -0400
Received: from zit-mailfront1.uni-paderborn.de ([131.234.200.2]:37328 "EHLO
	zitmail.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S1750934AbWDIVzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:55:51 -0400
Message-ID: <443982E2.8070403@uni-paderborn.de>
Date: Sun, 09 Apr 2006 23:55:46 +0200
From: Bjoern Schmidt <bj-schmidt@uni-paderborn.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: udp kernel socket problem
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=53D27ADB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

i wrote a kernel driver which sends data as payload of an udp packet via
a udp kernel socket.

The problem is that _not_ every sock_sendmsg() call puts a packet onto
the wire. Instead the data from several sock_sendmsg() calls will be
merged in one big udp packet and then put on the wire. (Is THAT called
CORK?)

How can i force the kernel to put one udp packet per sock_sendmsg()
call (immediately ) onto the wire?

Please CC because i am not a subscriber of this list!

- --
greetings
Bjoern Schmidt

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFEOYLiLR9iDVPSetsRAqgzAJ9GQSyO2l1venCyjwG4u653lpc6QwCgkBMS
lxnJjExKNg/8FT5DAGastcA=
=FgOJ
-----END PGP SIGNATURE-----
