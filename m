Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTFPO5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTFPO5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:57:20 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:18438 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263930AbTFPO5S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:57:18 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 2.4.21] meye driver update
Date: Mon, 16 Jun 2003 16:54:41 +0200
User-Agent: KMail/1.5.2
References: <20030615163138.GD1857@deep-space-9.dsnet> <200306151906.57099.fsdeveloper@yahoo.de> <20030615212935.GA1582@deep-space-9.dsnet>
In-Reply-To: <20030615212935.GA1582@deep-space-9.dsnet>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306161654.52825.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 June 2003 23:29, Stelian Pop wrote:
> On Sun, Jun 15, 2003 at 07:06:56PM +0200, Michael Buesch wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Sunday 15 June 2003 18:31, Stelian Pop wrote:
> > > Hi,
> >
> > Hi Stelian,
> >
> > > +void dma_free_coherent(struct pci_dev *dev, size_t size,
> >
> >                           ^^^^^^^^^^^^^^^^^^^
> >
> > > +                         void *vaddr, dma_addr_t dma_handle)
> >
> >                                          ^^^^^^^^^^^^^^^^^^^^^
> > Why do you define these unused parameters?
>
> Because it's backported from 2.5, and I took it as it, without
> editing.
>
> > > +{
> > > +        free_pages((unsigned long)vaddr, get_order(size));
> > > +}
> >
> > And why are they defined in 2.5, too, althought unused.
> > Is there some reason?
>
> Unused of ix86 because bus addresses are the same as virtual addresses.
> This is not however the case on other architetures, see
> Documentation/DMA-mapping.txt.

Yes, I now understand, why it is in 2.5, but isn't it better,
to remove these parameters from your patch, because it is only
a local copy in your driver and not used by any other drivers.
And your driver is (if I didn't miss something) for running on
i386 only; there is no other version of this function for
other architectures, that need these parameters.
So wouldn't it be better to simply remove them, because
they are completely useless. IMHO their
just confusing.

>
> Stelian.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 16:49:26 up 8 min,  1 user,  load average: 1.07, 0.96, 0.49

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+7do8oxoigfggmSgRAjbxAJsF5CkukHoBH5OEWE3ZRRDtfQKMGQCgjLTK
LWBs80NR2u/VcXW80FEfXY8=
=7/iJ
-----END PGP SIGNATURE-----

