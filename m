Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVDKTX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVDKTX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVDKTXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:23:00 -0400
Received: from linares.terra.com.br ([200.154.55.228]:58540 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S261892AbVDKTWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:22:36 -0400
X-Terra-Karma: -2%
X-Terra-Hash: 7dc26a04c279166a259f1b25442820e2
From: rafael2k <rafael@riseup.net>
To: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: pcnet_cs problems in ARM handheld
Date: Mon, 11 Apr 2005 16:22:52 +0000
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1839184.zpkP6SxJGH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504111622.54719.rafael@riseup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1839184.zpkP6SxJGH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi David and others kernel developers,
Thanx for your pcnet_cs driver! I use it since old days :-P

I bought a IC-CARD+ pcnet_cs compatible pcmcia nic, and i'm using it on a=20
StrongARM HP Jornada 710. My kernel is a 2.4.18-rmk3-hh10 and my pcmcia-cs=
=20
version is 3.1.33

=46rom dmesg I got this messages:

=2D-
jornada720_pcmcia_configure_socket(): config socket 0 vcc 50 vpp 0
jornada720_pcmcia_configure_socket(): config socket 0 vcc 50 vpp 0
eth0: NE2000 Compatible: io 0xc2800300, irq 114, hw_addr 00:80:C8:88:00:56
eth0: interrupt(s) dropped!
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=3D0x3, ISR=3D0x96, t=3D39.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=3D0x3, ISR=3D0x3, t=3D55.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=3D0x3, ISR=3D0x3, t=3D49.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=3D0x3, ISR=3D0x3, t=3D88.
eth0: interrupt(s) dropped!
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=3D0x3, ISR=3D0x3, t=3D77.
=2D-

Any suggestions?
I tried to change some values in pcnet_cs.c:
INT_MODULE_PARM(use_big_buf,    1);     /* i tried 0 */
INT_MODULE_PARM(delay_output,   0);     /* I tried 1 */
INT_MODULE_PARM(delay_time,     4);     /* I tried 6 */

but no change helped...

bye,
rafael diniz

=2D-=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
=2D+-
Engenharia da Computa=E7=E3o  --  Unicamp
Radio Muda, radiolivre.org, Centro de M=EDdia Independente, SubM=EDdia, GPSL
Chave PGP: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0x2FF86098
=2D> orkut sucks, e naum estou nessa porcaria <-
"Acreditar que um conhecimento pode ser vendido ou
comprado =E9 uma forma sutil (e cruel) de perpetuar a ignor=E2ncia."
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
=2D+-


--nextPart1839184.zpkP6SxJGH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBCWqReoZ5YIC/4YJgRAtIkAJ9wi4BAI0MHqQtAgeG2VVpUvvxKZwCdEYeM
np72kYruCTYxopsol9exBoY=
=hlor
-----END PGP SIGNATURE-----

--nextPart1839184.zpkP6SxJGH--
