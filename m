Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312283AbSCTX0l>; Wed, 20 Mar 2002 18:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312284AbSCTX0c>; Wed, 20 Mar 2002 18:26:32 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:50009 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S312283AbSCTX0L>; Wed, 20 Mar 2002 18:26:11 -0500
Date: Thu, 21 Mar 2002 00:26:10 +0100
From: Kurt Garloff <kurt@garloff.de>
To: Tom Epperly <tepperly@llnl.gov>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
Message-ID: <20020321002610.F5052@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Tom Epperly <tepperly@llnl.gov>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020320213530.87CFE308D@driftcreek.llnl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2002 at 01:35:30PM -0800, Tom Epperly wrote:
> The kernel log showed me that various standard programs such as
> /bin/sh are generating bogus illegal instruction traps on a legal
> opcode (0x55) as part of a standard function preamble. After receiving
> an illegal instruction trap on opcode (0x55), the modified kernel does
> a wbinvd() to flush the cache and a __flush_tlb() to flush the TLB
> and then retries the "illegal" opcode. The retry produces a second
> illegal instruction trap on the same legal opcode (0x55). Information
> from /var/log/messages is shown below.

The CPU is what triggers the exception.
So this sounds like a defect (or overheated) CPU to me.

OTOH, the kernel logs "invalid operand". Could you run ksymoops to get a
disassembly?
AFAICS, its a push %ebp instruction, which should not be illegal. So either
your stack is overflowing or my suspicion with the defect CPU is applicable.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8mRqSxmLh6hyYd04RAjseAJ9D9WFchN4IdWbh/rUcJ9C55RT6ngCgl4p9
HA1QFzDVq2UdL939jr2bu7U=
=jGsY
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
