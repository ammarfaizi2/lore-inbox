Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbRDWXdm>; Mon, 23 Apr 2001 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132575AbRDWXdc>; Mon, 23 Apr 2001 19:33:32 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:33036 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S132537AbRDWXdQ>; Mon, 23 Apr 2001 19:33:16 -0400
Date: Tue, 24 Apr 2001 01:31:50 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: read perf improved by mounting ext2?
Message-ID: <20010424013150.A6892@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have some memory reading some similar question somewhere (here?) but I'm
not sure there was an answer.

I do observe strange behaviour if read performance fo my IDE harddisk as
reported by hdparm (or doing linear reads with a self written program):
My FUJITSU MPG3409AT E is supposed to make slightly above 30MB/s. However,
it's connected to a PIIX4, which can only do UDMA33. So I expect something
between 25 and 30 MB/s maximumn speed.

I get it. But not over the whole disk.
Doing a read speed measurement on /dev/hda, I constantly get ~16 MB/s.
Not bad, but less than I'd expect. Measuring single partitions, some show
the same, some show significantly more, 26MB/s--18MB/s, depending on the
position of the partition on disk. Those look good!

There are enough partitions to see a clear pattern: Those with mounted ext2
filesystems perform better. Umounting them does not harm, they just need to
have been mounted once. reiser or (v)fat however don't improve anything.
swap does, as does a ext2 over raid5.

Kernel 2.4.3pre7; Dual iPIII-700 system; i440BX MoBo.

Is this to be expected? Blocksize issues? Readahead behaviour? What's
changed on ext2 mounting ... ?

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4h (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE65LtlxmLh6hyYd04RAmbOAKDaGwvMUFZQfUGFjT9DHW1R85cl7QCfT5Ag
CadqxILzgsLfn7XUqb++9/0=
=fDRe
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
