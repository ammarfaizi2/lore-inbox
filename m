Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTEHWgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTEHWff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:35:35 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:49315 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S262189AbTEHWf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:35:27 -0400
Date: Fri, 9 May 2003 00:47:59 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ptrace Issues
Message-Id: <20030509004759.46182eca.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
X-Outlook: <html><form><input type crash></form></html>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="Nw5HF0=.gRDBs4oU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Nw5HF0=.gRDBs4oU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi all,

I have discovered that recently I can no longer attach via strace to 
already running processes for a long time. Specifically I have a daemon which
sleeps in select and periodically wakes up from SIGALRM signals. As soon as a
signal hits, strace quits on 2.5.69, however, it works fine on 2.4.21-rc.
Can someone shed some light on what's going on?

root@Corona:~> strace -p 527
--- SIGSTOP (Stopped (signal)) ---
--- SIGSTOP (Stopped (signal)) ---
select(7, [0 3 6], [], NULL, NULL)      = ? ERESTARTNOHAND (To be restarted)
--- SIGALRM (Alarm clock) ---
root@Corona:~> echo $?
0

-Udo.

--Nw5HF0=.gRDBs4oU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+ut6inhRzXSM7nSkRAtqvAJ4k0OyA8uU8rZXmh1n5HyhQJZ9myACfcKym
+CJnLEQis/dNxORkQS3zAEc=
=nuvI
-----END PGP SIGNATURE-----

--Nw5HF0=.gRDBs4oU--
