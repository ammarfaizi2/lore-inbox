Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbTFZCxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 22:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbTFZCxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 22:53:45 -0400
Received: from h80ad2750.async.vt.edu ([128.173.39.80]:8320 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265346AbTFZCxo (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 22:53:44 -0400
Message-Id: <200306260307.h5Q37hCV003595@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, chris.ricker@genetics.utah.edu
Subject: Re: Hotplug/PPP oddness n 2.5.73-mm1 - scripts not running, bad event 
In-Reply-To: Your message of "Wed, 25 Jun 2003 14:58:35 PDT."
             <20030625145835.14206ec7.shemminger@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200306252028.h5PKSSnd002877@turing-police.cc.vt.edu>
            <20030625145835.14206ec7.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-940485865P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Jun 2003 23:07:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-940485865P
Content-Type: text/plain; charset=us-ascii

On Wed, 25 Jun 2003 14:58:35 PDT, Stephen Hemminger said:

> > This patch causes an external script API change.
> > Because network device go through the standard path, the action passed to t
he script
> > is no longer register or unregister but is now "add" or "remove" like other
 devices.
> > This is a good thing.  When testing (at least on RHAT) just change /etc/hot
plug/net.agent
> > case statement:
> > 	
> > case $ACTION in
> > add|register)

Yeah, that was the fairly obvious fix... now who's job is it to fix it on the
hotplug website, and when?  Also, who gets to update the currently non-existent
entry in Documentation/Changes (i've cc'ed Chris Ricker)?

Or should this just get tacked on the "to do before 2.6.0 comes out" list for
now?


--==_Exmh_-940485865P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE++mN/cC3lWbTT17ARAvWXAJ914d3LFeXfotLSGMMTRblu9SNeLgCgz/eC
JRO+g2l9LNK9MvVMsYIxskA=
=2bc3
-----END PGP SIGNATURE-----

--==_Exmh_-940485865P--
