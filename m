Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbSKDXQi>; Mon, 4 Nov 2002 18:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSKDXQi>; Mon, 4 Nov 2002 18:16:38 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:43495 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S262883AbSKDXQh>; Mon, 4 Nov 2002 18:16:37 -0500
Date: Tue, 5 Nov 2002 00:22:56 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Htree ate my hard drive, was: post-halloween 0.2
Message-Id: <20021105002256.553cd975.us15@os.inf.tu-dresden.de>
In-Reply-To: <20021104224213.F14318@redhat.com>
References: <20021030171149.GA15007@suse.de>
	<200210310727.52636.baldrick@wanadoo.fr>
	<20021031080717.GF28982@clusterfs.com>
	<20021104224213.F14318@redhat.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Pg:IaKI3(A5HE+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Pg:IaKI3(A5HE+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2002 22:42:13 +0000 Stephen C. Tweedie (SCT) wrote:

SCT> On Thu, Oct 31, 2002 at 01:07:17AM -0700, Andreas Dilger wrote:
SCT> > I wonder if there is still a bug in the e2fsck code for re-hashing
SCT> > directories?
SCT> 
SCT> Possibly, but I'm more worried about why the fsck did a directory
SCT> optimise on reboot, especially on the root filesystem (where /dev is
SCT> usually stored).  Doing major fs surgery on a mounted, readonly
SCT> filesystem is sort-of safe, but only if you reboot afterwards.
SCT> Continuing and remounting read-write can cause all sorts of damage as
SCT> the cached fs data no longer matches what's on disk.

Just a "me too". I've used htree with 2.5.44 and 2.4.20rc1. The next
fs check on the root filesystem founds corruption in /dev. After repairing
the damage and recreating the lost devices the machine ran ok for 2 days.
Then I had some ext3-fs errors and the partition got remounted read-only.
The following fsck revealed two inodes sharing the same block. I don't
have any logs of that incident anymore though :/

I'm running Slackware 9.0-beta and e2fsprogs-1.30-WIP.

Regards,
-Udo.

--=.Pg:IaKI3(A5HE+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9xwFUnhRzXSM7nSkRAopKAJ0ah2ZviPXPp6K0jRtm8TflYEBudwCdFX5U
V7satkwnAQ7lch3SjNGFqvo=
=qsGk
-----END PGP SIGNATURE-----

--=.Pg:IaKI3(A5HE+--
