Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265064AbRFZR7q>; Tue, 26 Jun 2001 13:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265071AbRFZR7g>; Tue, 26 Jun 2001 13:59:36 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:31128
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S265064AbRFZR7X>; Tue, 26 Jun 2001 13:59:23 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Tim Waugh <twaugh@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically 
In-Reply-To: Message from Tim Waugh <twaugh@redhat.com> 
   of "Tue, 26 Jun 2001 10:23:03 BST." <20010626102303.K7663@redhat.com> 
In-Reply-To: <Pine.LNX.4.21.0106260308100.1730-100000@freak.distro.conectiva>  <20010626102303.K7663@redhat.com> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1965377001P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Jun 2001 18:59:11 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E15Ex7I-0008TV-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1965377001P
Content-Type: text/plain; charset=us-ascii

>- change parport_pc so that it doesn't request parport_serial at
>  init.  In this case, how will parport_serial get loaded at all?
>  Perhaps with some recommended /etc/modules.conf lines (perhaps
>  parport_lowlevel{1,2,3,...})?

This would be a bit bad, because it would require people to guess whether they 
might have a card that parport_serial can drive and/or try loading the module 
to see what happens.

I guess one option would be for parport_pc to somehow "know" what cards are 
really multi-I/O ones, and only load parport_serial when it will be able to 
find something to do.  Doesn't seem all that appealing though.

>- parport_serial could be made to initialise successfully even if it
>  doesn't see any devices that it can drive.

If you do that then the code will effectively be there all the time, even when 
it's not needed.  You might as well just compile it in to parport_pc.  To be 
honest, there isn't all that much of it so maybe this wouldn't be such a bad 
idea.

p.



--==_Exmh_-1965377001P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7OM1vVTLPJe9CT30RAieVAKCSROwbdtLuu6AP00yiRO59LvYYegCfQ0D/
cdU+j8nHBcQS0fF2uozZKcU=
=WLTX
-----END PGP SIGNATURE-----

--==_Exmh_-1965377001P--
