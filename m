Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVGKXWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVGKXWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGKXU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 19:20:26 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:2554 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262256AbVGKXSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 19:18:05 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42D06531.9060903@stesmi.com> (Stefan Smietanowski's message of
 "Sun, 10 Jul 2005 02:00:49 +0200")
References: <20050630153738.GU11013@nysv.org>
	<200506301952.j5UJqPrn013513@laptop11.inf.utfsm.cl>
	<87wto5yo9o.fsf@evinrude.uhoreg.ca> <42D06531.9060903@stesmi.com>
X-Hashcash: 1:23:050711:stesmi@stesmi.com::MyEGjFa1J8JPnebe:00000000000000000000000000000000000000000000cxLp
X-Hashcash: 1:23:050711:vonbrand@inf.utfsm.cl::9olK4ssoRQfrP9B+:00000000000000000000000000000000000000009M3F
X-Hashcash: 1:23:050711:nikita@clusterfs.com::cdWJwHqsby//A92g:000000000000000000000000000000000000000000Wy/
X-Hashcash: 1:23:050711:doug@mcnaught.org::04q8XHsZExWElLFN:000000000000000000000000000000000000000000019UjM
X-Hashcash: 1:23:050711:mrmacman_g4@mac.com::E8+RG18753Ktnige:000000000000000000000000000000000000000000a7CS
X-Hashcash: 1:23:050711:ninja@slaphack.com::UwlCzvRLQE+2Bj+c:0000000000000000000000000000000000000000000DVFO
X-Hashcash: 1:23:050711:valdis.kletnieks@vt.edu::xyI4xoZT8jeiCxPT:00000000000000000000000000000000000000T7JJ
X-Hashcash: 1:23:050711:ltd@cisco.com::Na0D9t3Ky6WCBpts:00000YG/
X-Hashcash: 1:23:050711:gmaxwell@gmail.com::rciNzeiUmDs/I7V0:0000000000000000000000000000000000000000000G4PB
X-Hashcash: 1:23:050711:reiser@namesys.com::5iuEYfTirilwOjKl:000000000000000000000000000000000000000000167P7
X-Hashcash: 1:23:050711:jgarzik@pobox.com::GL8UN06moQXfuxid:00000000000000000000000000000000000000000000IHqt
X-Hashcash: 1:23:050711:hch@infradead.org::kq9piqkNq6silZmD:00000000000000000000000000000000000000000001wtUQ
X-Hashcash: 1:23:050711:akpm@osdl.org::csxfa2GMvHlPZsPv:0002TNGA
X-Hashcash: 1:23:050711:linux-kernel@vger.kernel.org::WysZfbWuPG37LzJH:000000000000000000000000000000000ithA
X-Hashcash: 1:23:050711:reiserfs-list@namesys.com::m00tOc1b3YPuzSRD:000000000000000000000000000000000002DFz5
Date: Mon, 11 Jul 2005 19:17:20 -0400
Message-ID: <87oe99vsov.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Mon, 11 Jul 2005 19:17:56 -0400 (EDT)
X-Miltered: at rhadamanthus with ID 42D2FE1E.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2005 02:00:49 +0200, Stefan Smietanowski <stesmi@stesmi.com> said:

> So basically if I write a program that works in both Gnome and KDE I
> should (according to your description) implement my own VFS that will
> use the Gnome or KDE VFS that will then use the OS VFS.

Either that, or use a whole lot of #ifdefs, or hope that GNOME and KDE
agree on a common VFS, or don't use their VFS and just use the basic OS
calls and lose the functionality (and portability) of the VFSes, or pick
one VFS and hope that the other users can adapt.

GNOME and KDE already have their own VFS.  I am not asking for anything
new.  If you don't like the idea of a VFS at that level, take it up with
the GNOME and KDE people.

> Is it only me finding that a little silly?

> I mean, if I am to have the same functionality under neither Gnome nor
> VFS and they don't support something I need I _NEED_ a vfs so that my
> program is so totally independent on anything at all.

> My program calling My VFS which calls KDE/Gnome's VFS which calls the
> OS VFS will be slowe than just calling the VFS immidiately - I do hope
> you can see that.

Of course.  It's probably slower than arranging the bits on the hard
drive directly, and hand-coding everything in assembly.  But there's
always a performance price to pay for maintaining the programmer's
sanity.  There's always a price to pay when writing cross-platform
stuff.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

