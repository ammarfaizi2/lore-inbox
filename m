Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVGEUrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVGEUrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGEUrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:47:33 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:48091 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261810AbVGEUrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:47:15 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Nikita Danilov <nikita@clusterfs.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <200506301952.j5UJqPrn013513@laptop11.inf.utfsm.cl> (Horst von
 Brand's message of "Thu, 30 Jun 2005 15:52:25 -0400")
References: <20050630153738.GU11013@nysv.org>
	<200506301952.j5UJqPrn013513@laptop11.inf.utfsm.cl>
X-Hashcash: 1:23:050705:vonbrand@inf.utfsm.cl::2n9As15r8MfN550Z:0000000000000000000000000000000000000001k4EJ
X-Hashcash: 1:23:050705:nikita@clusterfs.com::ICtKku2NHT68IQ73:000000000000000000000000000000000000000007SL3
X-Hashcash: 1:23:050705:doug@mcnaught.org::SMJ2ey5iAxflGBrB:000000000000000000000000000000000000000000003TC8
X-Hashcash: 1:23:050705:mrmacman_g4@mac.com::VAYDR4nsMuqYblMB:000000000000000000000000000000000000000001B4Oq
X-Hashcash: 1:23:050705:ninja@slaphack.com::1l1kmgrrG8RWkads:00000000000000000000000000000000000000000001SXY
X-Hashcash: 1:23:050705:valdis.kletnieks@vt.edu::9EwGZAbyS5OuI7Ep:00000000000000000000000000000000000000D64F
X-Hashcash: 1:23:050705:ltd@cisco.com::GjpkipLMZi107mRu:00008D65
X-Hashcash: 1:23:050705:gmaxwell@gmail.com::LyHII8IU4d9cS8pu:0000000000000000000000000000000000000000000FOLf
X-Hashcash: 1:23:050705:reiser@namesys.com::bu4u+XG62K5zL0B9:00000000000000000000000000000000000000000001o1n
X-Hashcash: 1:23:050705:jgarzik@pobox.com::hlS7+s/KydJEJd0w:00000000000000000000000000000000000000000000M72e
X-Hashcash: 1:23:050705:hch@infradead.org::lUYsmaZNOh4HT2ZV:00000000000000000000000000000000000000000000uDoz
X-Hashcash: 1:23:050705:akpm@osdl.org::2MkyXmovoEcgTCzf:00004chC
X-Hashcash: 1:23:050705:linux-kernel@vger.kernel.org::EUvWIwroIOa9A8Jo:0000000000000000000000000000000002Ctz
X-Hashcash: 1:23:050705:reiserfs-list@namesys.com::Vs7vX4gy4+L/8S4N:0000000000000000000000000000000000007n02
Date: Tue, 05 Jul 2005 16:46:27 -0400
Message-ID: <87wto5yo9o.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Tue, 05 Jul 2005 16:47:06 -0400 (EDT)
X-Miltered: at persephone with ID 42CAF17D.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005 15:52:25 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:

>> This doesn't even invalidate the userland VFSs of the other guys,
>> they're still needed for systems whose kernels don't have a metadata
>> facility.

> So the metadata facility in kernel won't be used, for portability's
> sake.

Oh gee.  Every operating system does threads differently.  Mozilla has
an abstraction layer called nspr that allows them to handle threads
portably.  glib/gtk has their own threads abstraction.  On Windows, nspr
will use the Windows method for handling threads.  On Linux, it will use
the Linux way.  On systems that don't support threads, it can usually
emulate it using timers.

It's the exact same thing with the userspace VFS.  If GNOME needs to
handle extended attributes, it can use one mechanism under one operating
system, or emulate it using some ugly hack on operating systems that
don't support extended attributes.

Isn't that the whole point of having a VFS?

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

