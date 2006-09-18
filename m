Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbWIRO7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbWIRO7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbWIRO7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:59:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:61596 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965279AbWIRO7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:59:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U8xOfjWSV41ysO/yWm+uDyeYybhDmdrYp9BhGL7oE0/4iQRmqTVFnOcfDc9oiOPuYlw/9OQbBt9RjII+wJENaFjSIT3/JaOZkF3ePbGF0MdIAUzZEnNLATZfS1oeYJ4gUJAysGvuqXcoBW/ASX4cVJztfiH5MXwwNoN48ZomL34=
Message-ID: <d120d5000609180759t42945f0bi496b3840818c218b@mail.gmail.com>
Date: Mon, 18 Sep 2006 10:59:16 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
Subject: Re: Exporting array data in sysfs
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200609181622.07681.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609181359.31489.eike-kernel@sf-tec.de>
	 <200609181541.57164.eike-kernel@sf-tec.de>
	 <d120d5000609180656t2c6be385r4ad21d52313ac187@mail.gmail.com>
	 <200609181622.07681.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> Dmitry Torokhov wrote:
> > On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > > Greg KH wrote:
> > > > On Mon, Sep 18, 2006 at 01:59:17PM +0200, Rolf Eike Beer wrote:
> > > > > Hi,
> > > > >
> > > > > I would like to put the contents of an array in sysfs files. I found
> > > > > no simple way to do this, so here are my thoughts in hope someone can
> > > > > hand me a light.
> > > >
> > > > What is wrong with using an attribute group for this kind of
> > > > information?
> > >
> > > Missing documentation. Yes, this looks like I could use this at least for
> > > the simple interfaces (which would be enough).
> >
> > I imoplemented sysfs arrays and array groups once:
> >
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1155.html
> >
> > Not sure if it still appliers. Maybe Greg will consider taking it in
> > if there is a user of this code.
>
> I guess we can add some once it is in :)
>
> It looks good, but I would change some minor things. If there is no read
> function given I would return -EIO instead of 0, this is how other places do
> it.

Yes, the patch was done when everyone returned 0 instead of -EIO. Also
there is kmalloc->kzalloc conversion, etc.

> The limitation to 999 entries should go.

It is not really a limitation but rather a safeguard. Do you really
expect to have arrays with that many attributes?

> But otherwise it looks very
> similar to what I had in mind.
>
> Thanks.
>
> Eike
>
>
>

-- 
Dmitry
