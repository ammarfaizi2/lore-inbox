Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282916AbRLBUBn>; Sun, 2 Dec 2001 15:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282647AbRLBUBW>; Sun, 2 Dec 2001 15:01:22 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14015 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282897AbRLBUBL>; Sun, 2 Dec 2001 15:01:11 -0500
Date: Sun, 2 Dec 2001 13:01:06 -0700
Message-Id: <200112022001.fB2K16Q12503@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@borntraeger.net (Christian =?iso-8859-1?q?Borntr=E4ger?=),
        acmay@acmay.homeip.net (andrew may),
        ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
In-Reply-To: <E16Acjq-0004M3-00@the-village.bc.nu>
In-Reply-To: <200112021941.fB2Jfmg12171@vindaloo.ras.ucalgary.ca>
	<E16Acjq-0004M3-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > I consider this issue closed. I'd suggest you contact Mandrake and get
> > them to upgrade to devfsd-v1.3.20, remove the boot script code and use
> > the RESTORE directive instead. This requires v1.2 of the devfs core
> > (found in 2.4.17-pre1).
> 
> So the devfs in 2.4.17pre isnt back compatible - definitely 2.5
> material then. This is the same sort of reason the 32bit uid quota
> code can't go into 2.4 proper. Its a pain but its not reasonable to
> expect every random devfs user to handle this in a stable tree
> update

I wouldn't say it's not back compatible. If you want to use a new
devfsd feature, then you need the new devfs. The key difference
between the old and new devfs core (aside from fixing those races) is
that the new devfs core will spit out an EEXIST warning message
whereas before it didn't. But his system still worked. It didn't
break.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
