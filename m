Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTGGW3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTGGW3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:29:31 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:56743 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264539AbTGGW33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:29:29 -0400
Date: Mon, 7 Jul 2003 23:44:01 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Elmer <elmer@linking.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-ac4 Adaptec 1210SA lost interrupt , Seagate 120G
Message-ID: <20030707224401.GA17070@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Elmer <elmer@linking.ee>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307080017060.2847-100000@server.linking.sise>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307080017060.2847-100000@server.linking.sise>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2003 at 12:42:32AM +0300, Elmer wrote:
> Tried them on every imaginable way:
> 
> 1. 2.4.21 + my own siimage slight patch, 2.4.21 + simage from ac4, 
> 	pure 2.4.21-ac4
> 2. apic, noapic, localapic
> 3. uni,smp motherboards, 4 of them
> 4. modules, compiled in, 
> 5. all of options from cards bios
> 
> /proc/interrupts reports 0 interrupts for ide2,3 , whatever I do.
> 
> after bootup, after attacking ide-disk driver, there are lost interrupts.
> it recognises disk as correct type, but no communication except:
> 
> 1. under XP it works (but there was no linux at that mb) 
> 2. hdparm lets change few flags under linux, but no -X succeeds
> 3. after waiting for minute those timeouts and booting up, then 
> /proc/ide/ide2/hde/*  reports sensible correct information
> 
> I have the card for few more days, anything to try ?

   I've tried this card with all of the hdparm options that I could
think of. I got no success either. However, Andre Hedrick claims[1] to
have got the SiI3112 and 3114 working in his tree (a couple of weeks
ago).  He's testing it[2] before release.

   Hugo.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105622034606015&w=2

[2] I believe that one of the tests is whether he's got paid for the
work by the people who contracted him to do it, which is where I
suspect the real delay is.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
                --- If it ain't broke,  hit it again. ---                

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/CfexssJ7whwzWGARAoIFAKCmYyD9+J+LQM5IMyhtKecJkcBu6wCdEtvr
J+J5LsA6V+qMa8zL8M6gGbI=
=OcQK
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
