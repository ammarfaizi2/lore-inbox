Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUI2OcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUI2OcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbUI2OaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:30:07 -0400
Received: from magic.adaptec.com ([216.52.22.17]:56715 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S268488AbUI2O2k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:28:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] gdth update
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Wed, 29 Sep 2004 16:28:34 +0200
Message-ID: <B51CDBDEB98C094BB6E1985861F53AF31EE083@nkse2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] gdth update
Thread-Index: AcSmL6Jj3VtbOxIKRX+xsRpbuIFoegAAJcvQ
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Christoph Hellwig" <hch@infradead.org>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: <arjanv@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks to all. I will make the proposed changes in the next version.

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Mittwoch, 29. September 2004 16:21
> To: Jörn Engel
> Cc: Leubner, Achim; arjanv@redhat.com; Linux Kernel Mailing List
> Subject: Re: [PATCH] gdth update
> 
> On Wed, Sep 29, 2004 at 03:43:01PM +0200, Jörn Engel wrote:
> > On Wed, 29 September 2004 14:15:57 +0200, Leubner, Achim wrote:
> > >
> > > > > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> > > > > +static irqreturn_t gdth_interrupt(int irq, void *dev_id, struct
> > > pt_regs *regs);
> > > > >  #else
> > > > > -static void gdth_interrupt(int irq,struct pt_regs *regs);
> > > > > +static void gdth_interrupt(int irq, void *dev_id, struct pt_regs
> > > *regs);
> > > > >  #endif
> > > >
> > > > this really is the wrong way to do such irq prototype compatibility in
> > > > drivers. *really*
> > > >
> > > So please tell me what the right way should be. It works without any
> > > problem.
> >
> > #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> > #define irqreturn_t void
> > #define IRQ_NONE
> > #define IRQ_HANDLED
> > #endif
> 
> Actually all these are in recent 2.4.x release.  So better check for
> #ifndef IRQ_HANDLED.

