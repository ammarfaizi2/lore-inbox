Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269895AbUJMWlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269895AbUJMWlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269890AbUJMWlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:41:21 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:27092 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S269896AbUJMWlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:41:04 -0400
Subject: Re: Fw: signed kernel modules?
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       rusty@ozlabs.au.ibm.com, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097664137.4440.5.camel@localhost.localdomain>
References: <1096544201.8043.816.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <1097626296.4013.34.camel@localhost.localdomain>
	 <1097664137.4440.5.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1097707239.14303.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 08:40:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 20:42, Alan Cox wrote:
> On Mer, 2004-10-13 at 01:11, Rusty Russell (IBM) wrote:
> > +		    unsigned long len,
> > +		    unsigned long offset,
> > +		    unsigned long elemsize,
> > +		    unsigned long num)
> > +{
> > +	/* We're careful with wrap here. */
> > +	if (offset > len)
> > +		return 0;
> > +	if (elemsize * num / num != elemsize)
> 
> Whoops bang "num 0 elements". That check set isn't safe standalone

Thanks, Alan.

I'd appreciate your opinion on the issue at hand.  Is it worth 600 lines
of ELF verification and canonicalization code so we can strip modules
without altering the signature?

Rusty.

