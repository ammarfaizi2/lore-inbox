Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274923AbTHPUc4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274928AbTHPUc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:32:56 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:30650 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S274923AbTHPUcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:32:53 -0400
Date: Sat, 16 Aug 2003 13:09:38 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Driver Core fixes for 2.6.0-test3
Message-ID: <20030816130938.H670@nightmaster.csn.tu-chemnitz.de>
References: <20030815182459.GA3755@kroah.com> <20030815215459.Y639@nightmaster.csn.tu-chemnitz.de> <20030816032833.GA6680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030816032833.GA6680@kroah.com>; from greg@kroah.com on Fri, Aug 15, 2003 at 08:28:33PM -0700
X-Spam-Score: -4.2 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19o7jH-0000CH-00*J0L21R7yJyY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 15, 2003 at 08:28:33PM -0700, Greg KH wrote:
> On Fri, Aug 15, 2003 at 09:54:59PM +0200, Ingo Oeser wrote:
[...]
> Hi, I've brought this back to lkml as I'm getting tired of private email
> threads about this topic.  Hope you don't mind.

I don't.

> > On Fri, Aug 15, 2003 at 11:25:00AM -0700, Greg KH wrote:
> > > Here's some driver core changes that do the following things:
> > > 	- remove struct device.name field and fix up remaining
> > > 	  subsystems
> > 
> > Could you point me to the rationale about this?
> > 
> > I for one considered "everything should have a name" policy very
> > useful and extendible.
> Naming databases belong in userspace.  For PCI, PnP, and USB we can
> determine the name ourselves from userspace using lspci, lspnp, and
> lsusb.  Getting rid of the name field prevents us from relying on kernel
> code when we shouldn't be.
 
lspci at least shows only name OR number, but never both
together. 
      
So that this tool is not very useful for name resolving in case
of problems, because you have no simple way to match your input
with its output. But don't worry, M$ does the same UI mistake and
this can be easily fixed.

But this shifting is a good reason. This also helps the "product
and company changing names" disease ;-)

> Hey, we're saving kernel memory, and this is a problem?  :)

;-)

> Hope this helps explain things.

Explains exactly what I liked to know. 

Many thanks and regards

Ingo Oeser
