Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbQLUBph>; Wed, 20 Dec 2000 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQLUBp2>; Wed, 20 Dec 2000 20:45:28 -0500
Received: from mail2.edu.stockholm.se ([193.12.6.147]:60678 "EHLO
	mail2.edu.stockholm.se") by vger.kernel.org with ESMTP
	id <S129774AbQLUBpL>; Wed, 20 Dec 2000 20:45:11 -0500
From: Thomas Habets <thomas@habets.pp.se>
To: linux-kernel@vger.kernel.org
Subject: PANIC: reproducable with nfs, lynx and kernel 2.4.0-test12
Date: Thu, 21 Dec 2000 02:14:35 +0100
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00122102143500.06834@marvin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

I'm not on the list, send private for more info

I got a kernel panic with 2.4.0-test12 on a p90 with 24 MB RAM.
It's a newly installed debian potato.

What I do to trigger the panic is:
mount otherbox:/export /mnt
cd /mnt
lynx www.pgpi.com
[ i click to download the latest pgp from norway over http ]
[ it downloads and asks where to save it, I just click enter for default ]

*crash*

A lot of stuff goes by that looks like (this is the last line of this kind):
[<c011c2c2>] [<c010b60e>] [<c01134e>] [<c02459fe>]

Followed by:
Code: 89 42 04 89 10 b8 01 00 00 00 c7 43 04 00 00 00 00 c7 03 00
Aiee, killing interrupt handler
Kernel panic: attempted to kill the idle task!
In interrupt handler - not syncing

NOTE that I just compiled the entire kernel source over that same nfs mount,
without problems, which leads me to think that it's not a hw issue.

More information availible by request.

---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.2" };
  char *pgpKey[]   = { "finger -m thompa@darkface.pp.se" };
  char pgpfinger[] = { "6517 2898 6AED EA2C 1015  DCF0 8E53 B69F 524B B541" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
MessageID: F/1sCKH/HYdhVYGAp9oLQgVrxJAoT9GU

iQA/AwUBOkFZgyhq6QqtSOhUEQLkvACfTEODuoCPF/Ve3EA1F8xIuT0ClL4AoPtw
MKFh2IhXngI87G4BGhRWKVuY
=CSfy
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
