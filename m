Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbTDFNrG (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTDFNrG (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:47:06 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:59586 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S262961AbTDFNrF (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 09:47:05 -0400
Date: Sun, 6 Apr 2003 15:58:14 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poweroff problem
Message-Id: <20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030406233319.042878d3.sfr@canb.auug.org.au>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	<20030406233319.042878d3.sfr@canb.auug.org.au>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.11claws3 (GTK+ 1.2.10; Linux 2.4.21-pre6)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="9KJpoStd=.pnJUG,"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--9KJpoStd=.pnJUG,
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Apr 2003 23:33:19 +1000 Stephen Rothwell (SR) wrote:

Hello,

SR> On 5 Apr 2003 06:08:04 -0000 "Anant Aneja" <anantaneja@rediffmail.com> wrote:
SR> >
SR> > I've got a problem with my 2.4.2-2 kernel.
SR> > after reaching the power down stage i get a :
SR> > 1. complete listing of the cpu registers
SR> > 2. a message saying sementaion fault with halt -i -p -d
SR> 
SR> Has it always done this?

I have the same problem with Linux-2.4.21-pre6. I don't know when this started
to happen because I pretty much never halt my machine.

SR> More likely a BIOS problem that is weel known.

It's not a BIOS problem here. halt works pretty well with Linux-2.5.66 here.
It's most likely an ACPI problem. What happens here is that the code to power
down actually does not manage to turn the machine off, instead after a while
the NMI watchdog kicks in and the kernel oopses.


-Udo.

--9KJpoStd=.pnJUG,
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+kDJ4nhRzXSM7nSkRAgBcAJ44kU4Rbe1d7Kc2P/3umZ8kBzebnQCfWO7Y
XAQP98CyGlRt+gWPbLpkEhc=
=5tKn
-----END PGP SIGNATURE-----

--9KJpoStd=.pnJUG,--
