Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVAPG6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVAPG6A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 01:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVAPG5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 01:57:53 -0500
Received: from faye.voxel.net ([69.9.164.210]:7632 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S262438AbVAPG5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 01:57:18 -0500
Subject: 2.6.10-as2
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2c6Lf5XhOYo1+kU/Qbzc"
Date: Sun, 16 Jan 2005 01:57:16 -0500
Message-Id: <1105858636.8083.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2c6Lf5XhOYo1+kU/Qbzc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Here's 2.6.10-as2.  Not too many changes, as I'm still going through
past bk changesets.  As requested by numerous people, I'm including the
changelog in the email (between -as1 and -as2); the full changelog is
available at the url below.  Thank you to the numerous people who
offered suggestions, fixes, and moral support. :)

The kernel patches can be grabbed from here:
http://www.acm.cs.rpi.edu/~dilinger/patches/2.6.10/as2/

534b04f3ca528bbb13d275ed83a1829e  ChangeLog
4df7735c1d780e4a185407b43a8d97c2  linux-2.6.10-as2.tar.gz
d4e6c6c7352147e908d42276e24e0833  patch-2.6.10-as2.gz

Here are the changes from 2.6.10-as1:

2005-01-16 05:02:31 GMT	Andres Salomon <dilinger@voxel.net>	patch-52

    Summary:
      tag 2.6.10-as2
    Revision:
      linux--dilinger--0--patch-52

   =20
   =20

    modified files:
     000-extraversion.patch


2005-01-16 05:01:53 GMT	Andres Salomon <dilinger@voxel.net>	patch-51

    Summary:
      fix up 048-matroxfb_mtrr_ifdef.patch
    Revision:
      linux--dilinger--0--patch-51

    Looks like some MODULE_PARM() -> module_param() conversions causes this=
 to
    not apply; fix the patch to apply.
   =20
   =20

    modified files:
     048-matroxfb_mtrr_ifdef.patch


2005-01-16 04:42:47 GMT	Andres Salomon <dilinger@voxel.net>	patch-50

    Summary:
      050-cfq_requeue_request_accounting.patch
    Revision:
      linux--dilinger--0--patch-50

    cfq_requeue_request can potentially decrement a counter past 0; we want
    to only decrement it if it's > 0.
   =20

    new files:
     .arch-ids/050-cfq_requeue_request_accounting.patch.id
     050-cfq_requeue_request_accounting.patch


2005-01-16 04:38:47 GMT	Andres Salomon <dilinger@voxel.net>	patch-49

    Summary:
      049-alpha_io_write_size.patch
    Revision:
      linux--dilinger--0--patch-49

    [ALPHA] some alpha-specific io write stuff is writing bytes instead of =
words.
    This patch fixes that.
   =20
   =20

    new files:
     .arch-ids/049-alpha_io_write_size.patch.id
     049-alpha_io_write_size.patch


2005-01-16 04:28:10 GMT	Andres Salomon <dilinger@voxel.net>	patch-48

    Summary:
      048-matroxfb_mtrr_ifdef.patch
    Revision:
      linux--dilinger--0--patch-48

    The mtrr stuff in the matroxfb driver needs to be wrapped w/ CONFIG_MTR=
R
    ifdefs.
   =20

    new files:
     .arch-ids/048-matroxfb_mtrr_ifdef.patch.id
     048-matroxfb_mtrr_ifdef.patch


2005-01-16 04:11:54 GMT	Andres Salomon <dilinger@voxel.net>	patch-47

    Summary:
      047-do_tcp_sendpages_tso_assertion.patch
    Revision:
      linux--dilinger--0--patch-47

    do_tcp_sendpages() didn't track skb->truesize correctly; this causes
    partially ACK'd TSO frames to potentially corrupt stuff as
    skb->truesize is too small.
   =20

    new files:
     .arch-ids/047-do_tcp_sendpages_tso_assertion.patch.id
     047-do_tcp_sendpages_tso_assertion.patch


2005-01-16 03:59:40 GMT	Andres Salomon <dilinger@voxel.net>	patch-46

    Summary:
      046-ipv6_sit_lock.patch
    Revision:
      linux--dilinger--0--patch-46

    Fix locking issue inside ipip6_tunnel_link().
   =20

    new files:
     .arch-ids/046-ipv6_sit_lock.patch.id 046-ipv6_sit_lock.patch


2005-01-16 03:45:40 GMT	Andres Salomon <dilinger@voxel.net>	patch-45

    Summary:
      045-pci_psycho_brainfart.patch
    Revision:
      linux--dilinger--0--patch-45

    [SPARC64] Incorrect register values are used inside
    __psycho_check_one_stc if PBM type is B.
   =20

    new files:
     .arch-ids/045-pci_psycho_brainfart.patch.id
     045-pci_psycho_brainfart.patch


2005-01-16 03:35:52 GMT	Andres Salomon <dilinger@voxel.net>	patch-44

    Summary:
      044-elevator_noop_add_request.patch
    Revision:
      linux--dilinger--0--patch-44

    elevator_noop_add_request() ignored the 'where' arg, which specified
    where the request should be added (front, back..)
   =20
   =20

    new files:
     .arch-ids/044-elevator_noop_add_request.patch.id
     044-elevator_noop_add_request.patch


2005-01-16 01:23:21 GMT	Andres Salomon <dilinger@voxel.net>	patch-43

    Summary:
      043-dothan_p4_get_frequency.patch
    Revision:
      linux--dilinger--0--patch-43

    Pentium M (Dothan) model is 0x0d, not 0x13.
   =20
   =20

    new files:
     .arch-ids/043-dothan_p4_get_frequency.patch.id
     043-dothan_p4_get_frequency.patch


2005-01-16 01:18:59 GMT	Andres Salomon <dilinger@voxel.net>	patch-42

    Summary:
      042-gx_get_cpuspeed_return_value.patch
    Revision:
      linux--dilinger--0--patch-42

    gx_get_cpuspeed was returning the wrong value; this fixes it.
   =20
   =20

    new files:
     .arch-ids/042-gx_get_cpuspeed_return_value.patch.id
     042-gx_get_cpuspeed_return_value.patch


2005-01-16 01:01:38 GMT	Andres Salomon <dilinger@voxel.net>	patch-41

    Summary:
      041-ide_hwif_supress_busy.patch
    Revision:
      linux--dilinger--0--patch-41

    While probing ide interfaces, supress error messages for non-existent
    one.
   =20
   =20

    new files:
     .arch-ids/041-ide_hwif_supress_busy.patch.id
     041-ide_hwif_supress_busy.patch


2005-01-16 00:53:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-40

    Summary:
      040-sk_forward_alloc_underflow.patch
    Revision:
      linux--dilinger--0--patch-40

    Do not underflow sk_forward_alloc from tcp_sendpage.
   =20
   =20

    new files:
     .arch-ids/040-sk_forward_alloc_underflow.patch.id
     040-sk_forward_alloc_underflow.patch


2005-01-15 23:48:43 GMT	Andres Salomon <dilinger@voxel.net>	patch-39

    Summary:
      039-serial_console_resume.patch
    Revision:
      linux--dilinger--0--patch-39

    Don't assume a port has a tty associated w/ it when resuming.
   =20

    new files:
     .arch-ids/039-serial_console_resume.patch.id
     039-serial_console_resume.patch


2005-01-15 23:18:06 GMT	Andres Salomon <dilinger@voxel.net>	patch-38

    Summary:
      038-ftdi_sio_debug_output.patch
    Revision:
      linux--dilinger--0--patch-38

    Make ftdi_sio driver output debug message instead of error if attemptin=
g
    to write 0 bytes.
   =20
   =20

    new files:
     .arch-ids/038-ftdi_sio_debug_output.patch.id
     038-ftdi_sio_debug_output.patch


2005-01-15 21:43:50 GMT	Andres Salomon <dilinger@voxel.net>	patch-37

    Summary:
      037-sctp_err_lookup_oops.patch
    Revision:
      linux--dilinger--0--patch-37

    In case of an error, sk never gets set; thus, sock_put(sk) messes up.
   =20
   =20
   =20

    new files:
     .arch-ids/037-sctp_err_lookup_oops.patch.id
     037-sctp_err_lookup_oops.patch


2005-01-15 21:39:24 GMT	Andres Salomon <dilinger@voxel.net>	patch-36

    Summary:
      036-rlimit_memlock_check-2.patch
    Revision:
      linux--dilinger--0--patch-36

    Add missing memory check; needed by 033-rlimit_memlock_check.patch.
   =20
   =20

    new files:
     .arch-ids/036-rlimit_memlock_check-2.patch.id
     036-rlimit_memlock_check-2.patch



   =20

--=20
Andres Salomon <dilinger@voxel.net>

--=-2c6Lf5XhOYo1+kU/Qbzc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB6hBM78o9R9NraMQRArkIAJwNf+FYkN61M3fxkeMLMHRw4LO+sACfdpbf
k4USMSm17UuS5kuKxD5YUZw=
=48qN
-----END PGP SIGNATURE-----

--=-2c6Lf5XhOYo1+kU/Qbzc--

