Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTFKSgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTFKSgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:36:42 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:50798 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262811AbTFKSgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:36:40 -0400
Subject: Re: [PATCHSET] 2.4.21-rc6-dis3 released
From: Disconnect <kernel@gotontheinter.net>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200306102207.02870.torsten.foertsch@gmx.net>
References: <1055195284.19815.55.camel@slappy>
	 <200306102207.02870.torsten.foertsch@gmx.net>
Content-Type: text/plain
Organization: 
Message-Id: <1055357410.1338.183.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 14:50:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What gcc version are you using?

Using 3.2.3 I built modules with your config and no problems - make
mrproper ; cp config .config ; make oldconfig ; make dep && make clean
&& make modules worked fine...

gcc 3.3 has issues with kernel building, afaik.

On Tue, 2003-06-10 at 16:06, Torsten Foertsch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Monday 09 June 2003 23:48, Disconnect wrote:
> > Bug reports welcome, and nvidia users, I'm still looking to hear from
> > more of you.  (Those of you who have responded already should have
> > replies by now; if not, let me know..)
> >
> > The patch is against 2.4.21-rc6 and is available at
> > http://www.gotontheinter.net/kernel/ (including an untested update to
> > rc7)
> 
> I tried it but make modules stopped with
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-rc6-dis3/include -Wall 
> - -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> - -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE 
> - -DMODVERSIONS -include 
> /usr/src/linux-2.4.21-rc6-dis3/include/linux/modversions.h  -nostdinc 
> - -iwithprefix include -DKBUILD_BASENAME=sound  -DEXPORT_SYMTAB -c sound.c
> sound.c:29:27: sound/version.h: No such file or directory
> sound.c:322:100: warning: pasting "(" and "KERN_ERR" does not give a valid 
> preprocessing token
> sound.c:394:95: warning: pasting "(" and "KERN_ERR" does not give a valid 
> preprocessing token
> make[2]: *** [sound.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.21-rc6-dis3/sound/core'
> make[1]: *** [_modsubdir_core] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.21-rc6-dis3/sound'
> make: *** [_mod_sound] Error 2
> 
> Then I grep'ed linux-2.4.20.tar.bz2, patch-2.4.21-rc6.bz2 and your patchset 
> (2.4.21-rc6-dis3-final.diff.bz2) for a sound/version.h but found none.
> 
> What did I wrong?
> 
> Please find my .config attached.
> 
> Thanks,
> Torsten
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.7 (GNU/Linux)
> 
> iD8DBQE+5jpmwicyCTir8T4RAuN6AKCnWN3yc4vRGoUodF39qOzGrXGhjwCgj1tW
> vF7Bn3qvyvBOFm/v9OQdwvk=
> =8fJ8
> -----END PGP SIGNATURE-----

