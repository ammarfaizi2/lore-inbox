Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbUCDKiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 05:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUCDKiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 05:38:46 -0500
Received: from mx1.actcom.co.il ([192.114.47.13]:5832 "EHLO smtp1.actcom.co.il")
	by vger.kernel.org with ESMTP id S261820AbUCDKin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 05:38:43 -0500
Date: Thu, 4 Mar 2004 12:38:25 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: modules registering as sysctl handlers
Message-ID: <20040304103824.GA7206@mulix.org>
References: <20040302122909.GG24260@mulix.org> <20040302124106.GQ16357@parcelfarce.linux.theplanet.co.uk> <1078272339.15766.5.camel@bach> <20040303092239.GA31820@mulix.org> <20040303104332.GR16357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20040303104332.GR16357@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2004 at 10:43:32AM +0000, viro@parcelfarce.linux.theplanet.=
co.uk wrote:

> At least parport has both module-wide and per-port sysctls.  The
> latter are dynamic even if module support is turned off.  I seriously
> suspect that other examples are similar.

For reference, here's the list of register_sysctl_table() users from
2.6.3-bk with an "almost allmodconfig" configuration. Those that I've
randomly looked at all used a statically allocated ctl_table
structure. Will adding a .owner field to it with the relevant
module_get/module_put in the registration functions hinder future
efforts to fix it properly? It won't be perfect, but it will be better
than what we currently have.=20

=2E/drivers/cdrom/cdrom.ko uses register_sysctl
=2E/drivers/char/rtc.ko uses register_sysctl
=2E/drivers/cpufreq/cpufreq_userspace.ko uses register_sysctl
=2E/drivers/md/md.ko uses register_sysctl
=2E/drivers/net/wireless/arlan.ko uses register_sysctl
=2E/drivers/parport/parport.ko uses register_sysctl
=2E/drivers/scsi/scsi_mod.ko uses register_sysctl
=2E/fs/coda/coda.ko uses register_sysctl
=2E/fs/lockd/lockd.ko uses register_sysctl
=2E/fs/ntfs/ntfs.ko uses register_sysctl
=2E/fs/xfs/xfs.ko uses register_sysctl
=2E/net/appletalk/appletalk.ko uses register_sysctl
=2E/net/ax25/ax25.ko uses register_sysctl
=2E/net/bridge/bridge.ko uses register_sysctl
=2E/net/decnet/decnet.ko uses register_sysctl
=2E/net/ipv4/ipvs/ip_vs_lblc.ko uses register_sysctl
=2E/net/ipv4/ipvs/ip_vs_lblcr.ko uses register_sysctl
=2E/net/ipv4/ipvs/ip_vs.ko uses register_sysctl
=2E/net/ipv4/netfilter/ip_conntrack.ko uses register_sysctl
=2E/net/ipv4/netfilter/ip_queue.ko uses register_sysctl
=2E/net/ipv6/netfilter/ip6_queue.ko uses register_sysctl
=2E/net/ipv6/ipv6.ko uses register_sysctl
=2E/net/ipx/ipx.ko uses register_sysctl
=2E/net/irda/irda.ko uses register_sysctl
=2E/net/netrom/netrom.ko uses register_sysctl
=2E/net/rose/rose.ko uses register_sysctl
=2E/net/rxrpc/rxrpc.ko uses register_sysctl
=2E/net/sctp/sctp.ko uses register_sysctl
=2E/net/sunrpc/sunrpc.ko uses register_sysctl
=2E/net/unix/unix.ko uses register_sysctl
=2E/net/x25/x25.ko uses register_sysctl

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARwcgKRs727/VN8sRAsdVAJ9Gs9NsW1glIqZxJMbZBzCSDbLcqQCfdftf
IoWUKnexjrI3+QgljXhzLgc=
=CHIr
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
