Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271950AbRIDL2E>; Tue, 4 Sep 2001 07:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271951AbRIDL1z>; Tue, 4 Sep 2001 07:27:55 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36144 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271950AbRIDL1i>; Tue, 4 Sep 2001 07:27:38 -0400
Date: Tue, 4 Sep 2001 12:27:51 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Michael Ben-Gershon <mybg@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lpr to HP laserjet stalls
Message-ID: <20010904122751.S20060@redhat.com>
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <3B94B4E7.701C76FA@netvision.net.il> <20010904121523.Q20060@redhat.com> <3B94B93B.2B907DCF@netvision.net.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2sscIVzdTs0oV1fw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B94B93B.2B907DCF@netvision.net.il>; from mybg@netvision.net.il on Tue, Sep 04, 2001 at 02:21:31PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2sscIVzdTs0oV1fw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2001 at 02:21:31PM +0300, Michael Ben-Gershon wrote:

> Please excuse my ignorance, but if it detects the IRQ and does not use it,
> how is it possible to set up interrupt-driven mode?

For interrupt-driven mode: irq=auto dma=nofifo
For PIO mode: irq=auto dma=none
For DMA mode: irq=auto dma=auto

You need to check the 'dmesg' output after parport_pc has loaded to
see exactly what it will use though (i.e. whether it has detected
usable hardware).

The line that goes 'parport0: PC-style at 0x378 (0x778)' is the
important one.  Ignore the stuff in [brackets] at the end; if an
interrupt is mentioned it is using it; if a DMA channel is mentioned,
it is using it; and if it says 'using FIFO' then it's using the FIFO
with programmed IO (rather than DMA).

Tim.
*/

--2sscIVzdTs0oV1fw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lLq3ONXnILZ4yVIRAr37AJ4ixajfho0/0Jtc8IZ+addPvk/4QACgl49T
5UXzCi8ewE0b08glDq+wyQM=
=HiGq
-----END PGP SIGNATURE-----

--2sscIVzdTs0oV1fw--
