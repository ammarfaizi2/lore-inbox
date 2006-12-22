Return-Path: <linux-kernel-owner+w=401wt.eu-S1423107AbWLVPGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423107AbWLVPGD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 10:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423156AbWLVPGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 10:06:02 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41588 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423107AbWLVPGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 10:06:00 -0500
Date: Fri, 22 Dec 2006 10:05:59 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
In-reply-to: <74d0deb30612212316i12090ca0hfe8524a80f63475a@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Message-id: <Pine.LNX.4.64.0612221004030.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200611111541.34699.david-b@pacbell.net>
 <200612201304.03912.david-b@pacbell.net>
 <200612201313.22572.david-b@pacbell.net>
 <20061220221328.ee3bfc5d.akpm@osdl.org>
 <74d0deb30612212316i12090ca0hfe8524a80f63475a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006, pHilipp Zabel wrote:

> On 12/21/06, Andrew Morton <akpm@osdl.org> wrote:
> > On Wed, 20 Dec 2006 13:13:21 -0800
> > David Brownell <david-b@pacbell.net> wrote:
> >
> > > +#define gpio_get_value(gpio) \
> > > +     (GPLR & GPIO_GPIO(gpio))
> > > +
> > > +#define gpio_set_value(gpio,value) \
> > > +     ((value) ? (GPSR = GPIO_GPIO(gpio)) : (GPCR(gpio) =
> > > GPIO_GPIO(gpio)))
> >
> > likewise.
> 
> I have done the same to the SA1100 wrappers as to the PXA wrappers now.
> Maybe the non-inline functions in generic.c are overkill for those much
> simpler
> macros on SA...

I think the SA1x00 has no advantage of having out of line versions.  The 
function call will cost more than the inline version even if gpio is not 
constant.


Nicolas
