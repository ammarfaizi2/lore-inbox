Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319038AbSHFKK3>; Tue, 6 Aug 2002 06:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSHFKK3>; Tue, 6 Aug 2002 06:10:29 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:61611 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S319038AbSHFKK2>;
	Tue, 6 Aug 2002 06:10:28 -0400
Date: Tue, 6 Aug 2002 12:17:51 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Tim Hockin <thockin@hockin.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
Message-ID: <20020806121751.A26908@crystal.2d3d.co.za>
Mail-Followup-To: Tim Hockin <thockin@hockin.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <3D4E9CE4.8060808@mandrakesoft.com> <200208051906.g75J6d122986@www.hockin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208051906.g75J6d122986@www.hockin.org>; from thockin@hockin.org on Mon, Aug 05, 2002 at 12:06:39 -0700
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 12:06pm  up 6 days, 17:22,  7 users,  load average: 0.03, 0.03, 0.04
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tim!

> These are the valid parameters to the SIOCETHTOOL ioctl().  Network drive=
rs
> should support these as much as possible.
>=20
> ETHTOOL_GSET
> ETHTOOL_SSET
>=20
>   Get/set NIC settings.  These commands expect a 'struct ethtool_cmd *'
>   argument.  This struct includes fields for supported features (speed,
>   duplex, transceiver), advertised features, speed, duplex, port,
>   transceiver, and autonegotiation.  If the caller attempts to set an
>   invalid value for any field, return -EINVAL.

What is the difference between the supported and advertising fields?
What is MII? (as in the SUPPORTED_MII feature?).

If you can't control the # of ints before Tx/Rx, I take it you can just
set those fields to 0?

> ETHTOOL_GDRVINFO
>=20
>   Get driver information.  This command expects a 'struct ethtool_drvinfo=
 *'
>   argument.  This struct includes the driver identifier as a string, the
>   driver version as a string, bus information for the interface, and leng=
th
>   information for other ETHTOOL_* commands.

What do you set the bus_info field to if there is no bus? Where are all
these bus types defined? The header file isn't very clear about anything
other than pci bus types.

I take it you can just set fw_version to zero length string if it is unknow=
n?

> ETHTOOL_GEEPROM
> ETHTOOL_SEEPROM
>=20
>   Get/set EEPROM data.  These commands expect a 'struct ethtool_eeprom *'
>   argument.  This struct has a magic number, an offset and length pair, a=
nd a
>   data field.  If the offset+length are longer than the maximum size, the
>   extra is silently ignored.

Wouldn't it have been better to make this 'n character device which can be
read from / written to just like a normal file (/dev/nvram-like interface) -
that way applications can actually use unused eeprom space.

> ETHTOOL_GCOALESCE
> ETHTOOL_SCOALESCE
>=20
>   Get/set coalescing parameters.  These commands expect a 'struct
>   ethtool_coalesce *' argument.  This struct has several fields for
>   configuring coalescing - see ethtool.h for details.  If the caller
>   attempts to set an invalid value, return -EINVAL.

Wtf is coalescing parameters? These commands aren't even defined in the
2.4.18 kernel headers. Is this 2.5.xx additions?

Same goes for the following commands:

> ETHTOOL_GRINGPARAM
> ETHTOOL_SRINGPARAM
> ETHTOOL_GPAUSEPARAM
> ETHTOOL_SPAUSEPARAM
> ETHTOOL_GRXCSUM
> ETHTOOL_SRXCSUM
> ETHTOOL_GTXCSUM
> ETHTOOL_STXCSUM
> ETHTOOL_GSG
> ETHTOOL_SSG
> ETHTOOL_TEST
> ETHTOOL_GSTRINGS
> ETHTOOL_PHYS_ID
> ETHTOOL_GSTATS

--=20

Regards
 Abraham

Lying is an indispensable part of making life tolerable.
		-- Bergan Evans

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9T6JPzNXhP0RCUqMRAnIUAJ9yAORxK/Ihja7frAWBIfn/NLgpQACeN30k
QsCw7NuGBGauujsZU21aSiM=
=0iH3
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
