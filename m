Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWJ1RyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWJ1RyH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWJ1RyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:54:07 -0400
Received: from pool-72-66-199-112.ronkva.east.verizon.net ([72.66.199.112]:20932
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751234AbWJ1RyE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:54:04 -0400
Message-Id: <200610281753.k9SHrcE9005959@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2 - process_session-helper breaks /sbin/killall5
In-Reply-To: Your message of "Fri, 27 Oct 2006 21:47:34 PDT."
             <20061027214734.baf647cf.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610280318.k9S3Ie72012885@turing-police.cc.vt.edu>
            <20061027214734.baf647cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162058018_5794P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Oct 2006 13:53:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162058018_5794P
Content-Type: text/plain; charset=us-ascii

On Fri, 27 Oct 2006 21:47:34 PDT, Andrew Morton said:
>
> > System works fine, except when you go to shutdown.  When it hits the /sbin/killall5
> > call in /etc/init.d/halt, it kills *all* the processes, and we get a
> > nice message 'INIT: no more processes in current runlevel', and we're dead in
> > the water.  Checking with alt-sysrg-T shows that in fact, the only things
> > left running are the various kernel threads.  As near as I can tell, killall5
> > wasn't able to tell that its parent process was part of its process group,
> > so didn't refrain from killing it.
> > 
> > Any ideas/clues?
> 
> did you apply the hotfixes?

D'Oh!.  It took me about 3 days to get around to building -rc2-mm2, and I
*did* check the hotfix directory first, and all that was there was a powerpc
patch.  Apparently the one I needed got dropped into that directory about 2
hours later. :)

Is working now. :)


--==_Exmh_1162058018_5794P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFQ5kicC3lWbTT17ARAlzCAKCdYdPKN6eBFsaj1HP7DIhsabtKRwCgsIXa
IHgDjWzDD2q52bliHJBNwfU=
=CrHD
-----END PGP SIGNATURE-----

--==_Exmh_1162058018_5794P--
