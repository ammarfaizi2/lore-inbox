Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWFFNBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWFFNBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWFFNBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:01:48 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:5573
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932155AbWFFNBr (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:01:47 -0400
Message-Id: <200606061301.k56D12mH004130@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, arjan@infradead.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org, stefanr@s5r6.in-berlin.de
Subject: Re: 2.6.17-rc5-mm3-lockdep -
In-Reply-To: Your message of "Tue, 06 Jun 2006 09:00:18 +0159."
             <44852819.2080503@gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu>
            <44852819.2080503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149598862_3888P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Jun 2006 09:01:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149598862_3888P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Jun 2006 09:00:18 +0159, Jiri Slaby said:
> Valdis.Kletnieks@vt.edu napsal(a):
> > It's living longer before it throws a complaint - we're making it out of
> > rc.sysinit and into rc5.d ;)  This time we were in an 'id' command from this:
> > 
> > test `id -u` = 0  || exit 4

> > [  464.687000] illegal {in-hardirq-W} -> {hardirq-on-W} usage.
> > [  464.687000] id/2700 [HC0[0]:SC0[1]:HE1:SE0] takes:
> > [  464.687000]  (&list->lock){++..}, at: [<c0351a07>] unix_stream_connect+0x334/0x408
> > [  464.687000] {in-hardirq-W} state was registered at:
> > [  464.687000]   [<c012dd45>] lockdep_acquire+0x67/0x7f
> > [  464.687000]   [<c0383f11>] _spin_lock_irqsave+0x30/0x3f
> > [  464.687000]   [<c02fa93f>] skb_dequeue+0x18/0x49
> > [  464.687000]   [<f086b7f1>] hpsb_bus_reset+0x5e/0xa2 [ieee1394]
> > [  464.687000]   [<f0887007>] ohci_irq_handler+0x370/0x726 [ohci1394]
> > [  464.687000]   [<c013f9a8>] handle_IRQ_event+0x1d/0x52
> > [  464.687000]   [<c0140bc4>] handle_level_irq+0x97/0xe3
> > [  464.687000]   [<c01045d0>] do_IRQ+0x8b/0xaf
> > [  464.687000] irq event stamp: 2964

> That one would be corrected now:
> http://lkml.org/lkml/2006/6/5/100

I'd agree, except I had already hit *that* one and applied Stefan's patches...

--==_Exmh_1149598862_3888P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhXyOcC3lWbTT17ARApJnAJ0faEIRylGWvQOg7rMPUJK/26Dj6wCeIQSs
CCpELoKlhRwqAkjPBrfBWTc=
=ZUDL
-----END PGP SIGNATURE-----

--==_Exmh_1149598862_3888P--
