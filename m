Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269134AbUIRHCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269134AbUIRHCT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUIRHCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:02:18 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:14688 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269134AbUIRHCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:02:12 -0400
Date: Sat, 18 Sep 2004 00:02:11 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] kbuild: use infobox instead of msgbox and 'sleep 5'
Message-ID: <20040918070211.GA4611@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040818i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This patch makes Menuconfig in 2.4 a bit more tolerable by using a more
appropriate type to show an informational dialog, than a immutable
message box that shows for precisely 5 seconds. This patch was
previously by Herbert Xu.

Marcelo, please apply.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

# origin: Debian (herbert)
# cset: n/a
# inclusion: not submitted
# description: use msgbox (with OK button) instead of infobox + sleep
# revision date: 2004-09-05

diff -urN kernel-source-2.4.26/scripts/Menuconfig kernel-source-2.4.26-1/sc=
ripts/Menuconfig
--- kernel-source-2.4.26/scripts/Menuconfig	2002-08-03 10:39:46.000000000 +=
1000
+++ kernel-source-2.4.26-1/scripts/Menuconfig	2003-02-22 14:08:24.000000000=
 +1100
@@ -490,10 +490,9 @@
 		case "$2" in
 		y)	echo -en "\007"
 			${DIALOG} --backtitle "$backtitle" \
-				  --infobox "\
+				  --msgbox "\
 This feature depends on another which has been configured as a module.  \
-As a result, this feature will be built as a module." 4 70
-			sleep 5
+As a result, this feature will be built as a module." 6 70
 			eval $1=3Dm ;;
 		m)	eval $1=3Dm ;;
 		c)	eval x=3D\$$1
@@ -557,8 +556,7 @@
 				eval $2=3D\"$3\"
 				echo -en "\007"
 				${DIALOG} --backtitle "$backtitle" \
-					--infobox "You have made an invalid entry." 3 43
-				sleep 2
+					--msgbox "You have made an invalid entry." 5 43
 			fi
=20
 			break
@@ -590,8 +588,7 @@
 				eval $2=3D\"$3\"
 				echo -en "\007"
 				${DIALOG} --backtitle "$backtitle" \
-					--infobox "You have made an invalid entry." 3 43
-				sleep 2
+					--msgbox "You have made an invalid entry." 5 43
 			fi
=20
 			break
@@ -957,8 +954,7 @@
 			else
 				echo -ne "\007"
 				$DIALOG	--backtitle "$backtitle" \
-					--infobox "File does not exist!"  3 38
-				sleep 2
+					--msgbox "File does not exist!"  5 38
 			fi
 		else
 			cat <<EOM >help.out
@@ -1021,8 +1017,7 @@
 			else
 				echo -ne "\007"
 				$DIALOG	--backtitle "$backtitle" \
-					--infobox "Can't create file!  Probably a nonexistent directory." 3 60
-				sleep 2
+					--msgbox "Can't create file!  Probably a nonexistent directory." 5 60
 			fi
 		else
 			cat <<EOM >help.out


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUvdc6OILr94RG8mAQLCgRAAh1PNsOXvVOoMCTHP+af2qaIouikPkcpc
tMgHTn4WVoK6MhpOIkqW0c9D5nWieX1OduDJYBmBofb+h6fzBjyH8gqye0c3/MGy
phJ81rbe6SyU5PJZzDP2cLejgB+o01qi+gR7BLbJuiGpjXp3F8zUIC6684PhTPod
3zndYbDHDVrbsc6+DljG8DUFV3WY/DUFlZdEjs2CeNAYqfjPyqfTGiJE11jK/7NB
rFHTkXMTSV5BzCr7lRKzI+OQ+k0SB8AzTnGfcM7OuVjvPoeZykjznyYZfVMYrJzS
Lkka1PhJcNHxS8EkAXVK6y5PjIj+jwDfw7u1g5AVg3LaZWREFo8YZW+jTQWBKZxi
2hSv0f1Ye0eQDNBflgiJOjV52t2HqFZEfenWz50SfEmSH7VRePEQEVDLYp69vXbw
hfHf+3vMhrnc1JPPtghn4JFI8t2y4A3fwZHQMu85ZX4KZYDX4dQJS2YtzPFSSMJo
e5TMi2FI2tUVccL8BwzKymRtZxhjeJ2ZQPKe3E3LSvO7Z88JBgCAwLqu6eM1Toy+
54dv6wSjTmRu2arVKUTXtRnIM6xgrZcwr+sXh6EhBEbX/xC1Ms+CpZ9szFquaI33
M+/LJDAECyqW2TRdQ1oQR0LuODdZXu16K1A0BLcoivW5VNOhvg+rX4crcL9A+oDa
bXwGYz5NjbQ=
=B9U+
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
