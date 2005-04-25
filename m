Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVDYNap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVDYNap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVDYNap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:30:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:982 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262608AbVDYNaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:30:39 -0400
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
From: Dave Hansen <haveblue@us.ibm.com>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       roland@topspin.com, hozer@hozed.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
In-Reply-To: <426C6E24.5050203@ammasso.com>
References: <20050411180107.GF26127@kalmia.hozed.org>
	 <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org>
	 <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org>
	 <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org>
	 <426BABF4.3050205@ammasso.com> <20050424205309.GA5386@kroah.com>
	 <426C151F.3000407@ammasso.com> <20050425010351.GA21246@kroah.com>
	 <426C6E24.5050203@ammasso.com>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 06:30:22 -0700
Message-Id: <1114435822.14501.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-24 at 23:12 -0500, Timur Tabi wrote:
> Greg KH wrote:
> > I know of at least 1 x86-32 box from a three-letter-named company with
> > this feature that has been shipping for a few _years_ now.  That box is
> > pretty much everywhere now, and I know that other versions of it are
> > also quite popular (despite the high cost...)
> 
> Hmm... Well, I think we were already planning on telling our customers that we don't 
> support hot-swap RAM.  Is there a CONFIG option for that feature?

The driver to do the ACPI portion of both add and remove is in the
kernel today, so it's certainly a feature that's coming relatively soon.

There is a large variety of x86_64, ppc64, ia64 and ia64 hardware that
will be doing memory hotplug.  I believe that every POWER5 system is
capable of supporting it, at least virtually.

I don't think your concerns end with memory hotplug.  The same
approaches to moving memory around will be used for NUMA memory
balancing and for memory defragmentation.  Can you say that your cards
will never be used on a system which has memory which becomes
fragmented?

-- Dave

