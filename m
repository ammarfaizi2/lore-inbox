Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291662AbSBNNzW>; Thu, 14 Feb 2002 08:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291659AbSBNNzN>; Thu, 14 Feb 2002 08:55:13 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:12808 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S291664AbSBNNy7>;
	Thu, 14 Feb 2002 08:54:59 -0500
Date: Thu, 14 Feb 2002 13:54:57 +0000
To: linux-kernel@vger.kernel.org
Subject: Fun with OOM on 2.4.18-pre9
Message-ID: <20020214135457.GA4394@amphibian.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: toad <mtoseland@cableinet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I do a make -j bzImage
I have 2 large processes (Kaffe) running in the background. They are
driven by scripts like this:

while true;
do su freenet -c java freenet.node.Main;
done

I have 512MB of RAM and no swap on 2.4.18-pre9.
Kernel eventually slows to a near complete halt, and starts killing
processes.
It kills Kaffe several times
Out of Memory: Killed process xyz (Kaffe)
(no I don't have logs, sorry)
Each time it's a different pid, having respawned from its parent
process. Then later, it apparently becomes unkillable - each time it
respawns it is *the same PID*. VT switching works, but otherwise the
system is unresponsive. It is not clear whether the make -j is still
running. Immediately before this, it did the same thing with dictd, but
eventually got around to Kaffe. After a fairly long wait I rebooted with
the reset switch.

Any more information useful? Is this known behaviour?

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8a8Gx9dS6LLJqPpURAoobAJ0RTrLuuMqx7YkMEB3xQNoWxohlNgCeI7bj
NbPXfXSLW4xPrk+9FKKLS5g=
=yKzK
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
