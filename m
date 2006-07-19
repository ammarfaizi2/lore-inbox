Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWGSTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWGSTFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWGSTFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 15:05:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8401 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030215AbWGSTFu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 15:05:50 -0400
Message-Id: <200607191904.k6JJ4cf0002159@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Tilman Schmidt <tilman@imap.cc>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
Subject: Re: Reiser4 Inclusion
In-Reply-To: Your message of "Wed, 19 Jul 2006 17:32:48 +0200."
             <44BE50A0.9070107@imap.cc>
From: Valdis.Kletnieks@vt.edu
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> <20060717155151.GD8276@merlin.emma.line.org> <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr> <20060718204718.GD18909@merlin.emma.line.org> <fake-message-id-1@fake-server.fake-domain> <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com>
            <44BE50A0.9070107@imap.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153335878_2943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jul 2006 15:04:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153335878_2943P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jul 2006 17:32:48 +0200, Tilman Schmidt said:
 
> Well, that doesn't make sense. You can't have your cake and eat it
> too. Either you have out-of-tree code or you haven't. Documents
> like stable_api_nonsense.txt explicitly discourage out-of-tree code,
> which is formally equivalent to saying that all kernel code should
> be in-tree. Therefore an attitude which says "go on developing that
> code out-of-tree, it's not ready for inclusion yet" is in direct
> contradiction with the foundations of the no-stable-API policy.

Which part of "read Documentation/SubmittingPatches.txt and do what it says,
or it doesn't get into the kernel" do you have trouble understanding?

It isn't a case of "out of tree code or you haven't". There's actually
*three* major categories:

1) Code that's already in-tree and maintained.  These guys don't need to
worry about the API, as it will usually get handled free of charge.

2) Code that's out-of-tree, but a potential (after possible rework) candidate
for submission (for instance, the hi-res timers, CKRM, some drivers, etc).
These guys need to forward-port their code for API changes as they work
towards getting their code into the tree.

3) Code that's out-of-tree, but is so far out in left field that there's
no way it will ever go in.  For instance, that guy with the MVS JCL emulator
better not be holding his breath waiting.  And quite frankly, nobody else
really cares whether they forward port their code or not.

--==_Exmh_1153335878_2943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvoJGcC3lWbTT17ARArjRAJ0VcX4zmqxOMRUnYFFPRpi1jRFBrwCeIdM9
ugnT7rKmP1XcBi6Zd5xJDCk=
=oIUW
-----END PGP SIGNATURE-----

--==_Exmh_1153335878_2943P--
