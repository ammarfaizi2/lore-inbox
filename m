Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWDYAVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWDYAVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWDYAVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:21:06 -0400
Received: from h80ad24de.async.vt.edu ([128.173.36.222]:60898 "EHLO
	h80ad24de.async.vt.edu") by vger.kernel.org with ESMTP
	id S932130AbWDYAVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:21:05 -0400
Message-Id: <200604250019.k3P0JmJQ004798@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Nix <nix@esperi.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>, casey@schaufler-ca.com,
       James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-Reply-To: Your message of "Mon, 24 Apr 2006 10:14:34 +0200."
             <20060424081433.GG440@marowsky-bree.de> 
From: Valdis.Kletnieks@vt.edu
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com> <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com> <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu> <32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com> <1145536803.3313.32.camel@moss-spartans.epoch.ncsc.mil> <87y7xzu4hj.fsf@hades.wkstn.nix> <1145629477.21749.146.camel@moss-spartans.epoch.ncsc.mil>
            <20060424081433.GG440@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145924387_2476P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 20:19:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145924387_2476P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Apr 2006 10:14:34 +0200, Lars Marowsky-Bree said:
> On 2006-04-21T10:24:37, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > (With AppArmor, of course, you never lose labels at all, because there
> > > aren't any.)
> > But you do lose preservation of security properties, e.g. renaming a
> > file suddenly moves it under different protection.  Same end result.
> 
> This is not correct, as far as I understand. As the app can only rename
> in it has access to both the old and the new path.

People seem to have a blind spot for this sort of thing.  Given *two* processes,
one of which can be convinced to do a rename, and another that can be convinced
to write a file, you can subvert everything (quite possibly in opposite order -
if you can get process A to write /etc/foobar, and process B to rename foobar
to passwd, you've won).

Those who think that 2 processes can't be subverted should consider that symlink
attacks have been around for a quarter of a century - and in that time, it's
*always* been "one process to create the symlink, another to follow it to disaster".


--==_Exmh_1145924387_2476P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETWsjcC3lWbTT17ARAnk6AKCQ3QYc080UPqerLvC/eTz3QO4dBQCfSylm
lAiefsOHhy71UeLhn+myLKE=
=qY93
-----END PGP SIGNATURE-----

--==_Exmh_1145924387_2476P--
