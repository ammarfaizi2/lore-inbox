Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbUJYBW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUJYBW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUJYBW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:22:28 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:32414 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S261650AbUJYBWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:22:04 -0400
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-101032808"
To: linux-kernel@vger.kernel.org
From: Timo Sirainen <tss@iki.fi>
Subject: readdir loses renamed files
Date: Mon, 25 Oct 2004 04:21:57 +0300
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-5-101032808
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

I'd have thought this had already been asked many times before, but 
google didn't show me anything.

My problem is that mails in a large maildir get temporarily lost. This 
happens because readdir() never returns a file which was just rename()d 
by another process. Either new or the old name would have been fine, 
but it's not returned at all.

Is there a chance this could get fixed? Every OS/filesystem I've tested 
so far has had the same problem, so I'll have to implement some extra 
locking anyway (so much for maildir being lockless), but it would be 
nice to have at least one OS where it works without the extra locking 
overhead.

I have a test program if someone wants to try it: 
http://dovecot.org/tmp/readdir.c

(and please Cc replies)

--Apple-Mail-5-101032808
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFBfFU1yUhSUUBViskRAnrDAJ9AtFYubVoiWZTQ6yhW1F2QQUw19gCgozYk
k5VV03rYScdosXDsZDV5f10=
=rZIc
-----END PGP SIGNATURE-----

--Apple-Mail-5-101032808--

