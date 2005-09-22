Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVIVIGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVIVIGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVIVIGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:06:11 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:10749
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S1751443AbVIVIGK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:06:10 -0400
Subject: RE: How to Force PIO mode on sata promise (Linux 2.6.10)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-class: urn:content-classes:message
Date: Thu, 22 Sep 2005 10:03:10 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <17AB476A04B7C842887E0EB1F268111E026FBD@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to Force PIO mode on sata promise (Linux 2.6.10)
thread-index: AcW/Icc+56C5Fc5NQY2nw7Bcc/NBSQAKWdog
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,
It was a good idea but it doesn't resolve the problem...

I add my card into the dma_black_list of the libata to force DMA disabled and the problem seems to no more appear...maybe PIO is so slow that the data has no time to be corrupted...
But I can NOT affirm that the problem is the DMA. 

I try the linux kernel 2.4,2.6.11, 2.6.12 and 2.6.13. More I try 2 different toolchains and the problem persists...

Another idea??

Thanks,

David

-----Message d'origine-----
De : linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] De la part de Chris Wedgwood
Envoyé : jeudi 22 septembre 2005 05:00
À : David Sanchez
Cc : Jeff Garzik; linux-kernel@vger.kernel.org
Objet : Re: How to Force PIO mode on sata promise (Linux 2.6.10)

On Wed, Sep 21, 2005 at 02:28:02PM +0200, David Sanchez wrote:

> I'm using the linux kernel 2.6.10 and busybox on an AMD db AU1550
> with a hdd connected to the pata port of a PCI card (Promise
> PDC20579).

Disable prefetch in lib/memcpy.S and see if that helps.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





