Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbULHQgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbULHQgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbULHQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:36:06 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:45544 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261257AbULHQgB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:36:01 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [4/6] Xen VMM #4: HAS_ARCH_DEV_MEM
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Wed, 8 Dec 2004 16:35:59 -0000
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D123065@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [4/6] Xen VMM #4: HAS_ARCH_DEV_MEM
Thread-Index: AcTdEvhDrBakfXu8QB6389zmRyc8rgALuPzA
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Ian Pratt" <Ian.Pratt@cl.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, <Steven.Hand@cl.cam.ac.uk>,
       <Christian.Limpach@cl.cam.ac.uk>, <Keir.Fraser@cl.cam.ac.uk>,
       <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any chance you could put the /dev/mem implementation into a 
> separate file, ala drivers/char/devmem.c and avoid the 
> ifdefs?  ARCH_HAS_DEV_MEM would have to become a CONFIG option then

On most architectures much of the /dev/kmem and /dev/mem implementation
can be shared, so I'm not sure its worth splitting it out into its own
file. I don't think the current ARCH_HAS_DEV_MEM approach is too ugly.
[The reason that read/write is different on arch xen is that we need to
explicitly map/unmap the I/O pages before accesing them].

Ian 
