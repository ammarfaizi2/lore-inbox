Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVAYNzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVAYNzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVAYNzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:55:46 -0500
Received: from smtp.ono.com ([62.42.230.12]:59721 "EHLO resmta05.ono.com")
	by vger.kernel.org with ESMTP id S261942AbVAYNzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:55:17 -0500
Message-ID: <41F64FB0.5050900@usuarios.retecal.es>
Date: Tue, 25 Jan 2005 14:54:56 +0100
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <rrey@usuarios.retecal.es>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc2] kernel BUG at fs/reiserfs/journal.c:2966!
References: <41F4434E.50000@usuarios.retecal.es> <20050124172732.7978d541.akpm@digeo.com>
In-Reply-To: <20050124172732.7978d541.akpm@digeo.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:

| Is this repeatable?
|
|     /* we aren't allowed to close a nested transaction on a different
|     ** filesystem from the one in the task struct
|     */
|     if (cur_th->t_super != th->t_super)
|       BUG() ;
|
| very strange.  What mount options are you using on that fs?

"defaults" options in Ubuntu Hoary... I dont know if ubuntu changes some
of the default mount options on reiserfs. The version of mount utility
is 2.12p-2ubuntu1

This afternoon I will try to reproduce the bug.


- --
Ramón Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
Planet AUGCyL - http://augcyl.org/planet/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9k+uw4Wp058o43cRAlTqAKDLNKSzXS7rtGKwgleoGvMcKlywyACfRMRp
TL634xQlUNeTVmotGmauy4o=
=x3hp
-----END PGP SIGNATURE-----
