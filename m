Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTILVAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTILVAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:00:37 -0400
Received: from smtp2.globo.com ([200.208.9.169]:61652 "EHLO mail.globo.com")
	by vger.kernel.org with ESMTP id S261874AbTILVAf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:00:35 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Date: Fri, 12 Sep 2003 18:00:24 -0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309121800.34765.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox escreveu:

> It will depend what disks you have.
A friend from a forum found out this on NetBSD:

/* 
     * Rev. <= 0x01 of the 3112 have a bug that can cause data 
     * corruption if DMA transfers cross an 8K boundary.  This is 
     * apparently hard to tickle, but we'll go ahead and play it 
     * safe. 
     */ 
    if (PCI_REVISION(pa->pa_class) <= 0x01) { 
       sc->sc_dma_maxsegsz = 8192; 
       sc->sc_dma_boundary = 8192; 
    }

It seems to be a bug only in the first revisions of the chip. Can anyone 
confirm this? My chip is revision 2 and it doesn't have this bug.

> You can up it again at runtime.

How do I set the rqsize on 2.6.x?

Marcelo Penna Guerra
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/YjPvD/U0kdg4PFoRAusNAKDiLWwPFAmmCH9L4AwhpKIkh5zkzQCeJ8JT
YRgXP0NIoM8hcWH8RvzwYr0=
=Z6aZ
-----END PGP SIGNATURE-----
