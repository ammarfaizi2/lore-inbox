Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbUDQNLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 09:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263982AbUDQNLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 09:11:51 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:5292 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263973AbUDQNL0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 09:11:26 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RELEASE]: megaraid unified driver version 2.20.0.B1
Date: Sat, 17 Apr 2004 15:11:17 +0200
User-Agent: KMail/1.6
Cc: "Mukker, Atul" <Atulm@lsil.com>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC544@exa-atlanta.se.lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC544@exa-atlanta.se.lsil.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404171511.18070.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Saturday 17 April 2004 08:40, Mukker, Atul wrote:
> > Typically, one includes a simple counter to ensure the loop is not 
> > infinite...
> > 
> > 	while (condition && (counter-- > 0))
> > 		cpu_relax()
> > 
> The hard part is arriving at the counter value. Given that this driver might
> run on a 700MHz singe cpu, one of my test servers :-( or a 3.2GHz SMP server
> - the typical counter value is difficult to set. But you are right, we
> should find out the typical time a cpu would take to execute so many
> iterations and base counter value over it.

Then you might use a udelay(1) instead. This should equalize this
effect, no?


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAgSz1U56oYWuOrkARApDLAKDRyAJk7wL4T2M5NDjo3sUVT9sXTACgiEmo
3NQ5RyBs8aIWxrrfCzlP4JM=
=3K/t
-----END PGP SIGNATURE-----
