Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWGFW6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWGFW6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWGFW6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:58:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58547 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751003AbWGFW6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:58:53 -0400
X-Sasl-enc: Qasvex26lafYgsc/qG2fSeG2iNZ+FXEk1PvsLHgX60FA 1152226730
Message-ID: <44AD9605.6000601@imap.cc>
Date: Fri, 07 Jul 2006 01:00:21 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1: printk delays
References: <6vtF8-99-7@gated-at.bofh.it>
In-Reply-To: <6vtF8-99-7@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B64BBDF2C856ECD8E1DAD37"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B64BBDF2C856ECD8E1DAD37
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

With kernel 2.6.18-rc1 I am experiencing strange delays before printk
messages from my driver appear in the syslog. The last couple of printk
lines only appear if I hit a key on the system keyboard. Even just
pressing and releasing a shift key will do. Other input, like connecting
with ssh from another computer and typing into that session or moving or
clicking the mouse, doesn't help. At the same time, userspace syslog
messages like those from sshd appear just fine.

Example excerpt from /var/log/messages:

> Jul  7 00:16:08 gx110 kernel: [  746.583136] gigaset: 0: if_write()
> Jul  7 00:16:08 gx110 kernel: [  746.583154] gigaset: CMD Transmit (10 bytes):
> Jul  7 00:16:08 gx110 kernel: [  746.583203] bas_gigaset: setting ATREADY time
> Jul  7 00:16:08 gx110 kernel: [  746.585887] bas_gigaset: write_command: sent 
> Jul  7 00:16:08 gx110 kernel: [  746.612869] gigaset: received response (6 byt
> Jul  7 00:16:28 gx110 sshd[6134]: Accepted publickey for ts from 192.168.59.12
> Jul  7 00:28:26 gx110 kernel: [  746.687844] gigaset: 0: if_write()
> Jul  7 00:28:26 gx110 kernel: [  746.687944] gigaset: CMD Transmit (17 bytes):
> Jul  7 00:28:26 gx110 kernel: [  746.688002] bas_gigaset: setting ATREADY time
> Jul  7 00:28:26 gx110 kernel: [  746.690803] bas_gigaset: write_command: sent 

Note how the PRINTK_TIME timestamps increase in sub-second increments
while syslogd's timestamps show an enormous gap after 00:16:08.

With kernel 2.6.17.1 on the same machine there are no such delays. All
printk messages appear immediately, and the deltas in PRINTK_TIME and
syslogd timestamps are quite consistent.

Regards
Tilman

-- 
Tilman Schmidt                                    E-Mail: tilman@imap.cc
Bonn, Germany
It is well known that a vital ingredient of success is not knowing that
what you're attempting can't be done. [Terry Pratchett, Equal Rites]

--------------enig6B64BBDF2C856ECD8E1DAD37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErZYOMdB4Whm86/kRAm9IAJ4+s14iISKVn4SmVDahANOY1tVZ6QCeL29B
ex/MRKWvj01ekmQGONOy50M=
=29gv
-----END PGP SIGNATURE-----

--------------enig6B64BBDF2C856ECD8E1DAD37--
