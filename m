Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262093AbREPVh6>; Wed, 16 May 2001 17:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262097AbREPVht>; Wed, 16 May 2001 17:37:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55823 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262093AbREPVhd>; Wed, 16 May 2001 17:37:33 -0400
Message-ID: <3B02F2EC.F189923@transmeta.com>
Date: Wed, 16 May 2001 14:36:44 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
		<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
		<3B02D6AB.E381D317@transmeta.com>
		<200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
		<3B02DD79.7B840A5B@transmeta.com> <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> >
> > Because you are now, once again, tying two things that are
> > completely and utterly unrelated: device classification and device
> > name.  It breaks every time someone comes out with a new device
> > which is "kind of like an old device, but not really," like
> > CD-writers (which was kind-of-like WORM, kind-of-like CD-ROM) and
> > DVD (kind-of-like CD)...
> 
> But all devices which export a CD-ROM interface will do so. So the
> device node that is associated with the CD-ROM driver will export
> CD-ROM semantics, and the trailing name will be "/cd".
> 
> Other interfaces a device exports, such as a CD-RW, appear as a
> different device node ("generic" for SCSI, because we have no CD-RW
> classification at this point).
> 
> My scheme works already, and works reliably. Nothing had to be done to
> support the CD-ROM interface to CD-RW and DVD devices.
> 

It's still completely braindamaged: (a) these interfaces aren't
disjoint.  They refer to the same device, and will interfere with each
other; (b) it is highly undesirable to tie the naming to the interfaces
in this way.  It further restricts the namespaces you can export, for one
thing.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
