Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272222AbTGYQr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 12:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTGYQr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 12:47:58 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:51207 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S272222AbTGYQrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 12:47:55 -0400
Date: Fri, 25 Jul 2003 10:02:55 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725170255.GN23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Sam Bromley <sbromley@cogeco.ca>,
	Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8/wErwm0bqugfcz"
Content-Disposition: inline
In-Reply-To: <20030725161803.GJ1512@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--e8/wErwm0bqugfcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2003 at 12:18:04PM -0400, Ben Collins wrote:
> Ok, in ieee1394_core.c, when it does the "packet removed in
> abort_timedouts" could you make it print the value of jiffies, expire
> and packet->sendtime?


So, abort_timedouts() is called by the scheduler as part of work queue
handling?  Every HZ or based on the expire timeout?

It looks like (packet->sendtime - jiffies) is always 99.

-Chris


ieee1394: Initiating ConfigROM request for node 00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts
ieee1394: TLABEL: jiffies 612965374, expire 98, packet->sendtime 612965275
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 60f30404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00160 ffc00000 00000000 60f30404
ieee1394: TLABEL: Checking for tlabel 0
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00160 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc00540 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts
ieee1394: TLABEL: jiffies 612965808, expire 98, packet->sendtime 612965709
ieee1394: received packet: ffc00540 ffc0ffff f0000400
ieee1394: send packet local: ffc00560 ffc00000 00000000 60f30404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00560 ffc00000 00000000 60f30404
ieee1394: TLABEL: Checking for tlabel 1
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00560 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc00940 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts
ieee1394: TLABEL: jiffies 612966242, expire 98, packet->sendtime 612966143
ieee1394: received packet: ffc00940 ffc0ffff f0000400
ieee1394: send packet local: ffc00960 ffc00000 00000000 60f30404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00960 ffc00000 00000000 60f30404
ieee1394: TLABEL: Checking for tlabel 2
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00960 ffc00000 00000000 60f30404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394_0: Starting transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008011
ohci1394_0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 data=0x1F0000C0 ctx=0
ieee1394: TLABEL: not pending or no response expected, returning


--e8/wErwm0bqugfcz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IWK/KO6EG1hc77ERAl0vAJ9xylEkHYxuHDJwC2MQfZ7osynBEQCgxNs7
pBVzvdYwDOd36tyuMY9HgmU=
=xauW
-----END PGP SIGNATURE-----

--e8/wErwm0bqugfcz--
