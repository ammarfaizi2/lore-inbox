Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWGHOMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWGHOMi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWGHOMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:12:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:29396 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964847AbWGHOMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:12:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TEt7Ny16JL4I024lNuCsNKBoIax3gA4fWSsvkznMRmh4nIGOSGOE6PdGfKnHA/IgjuyHab9Iq49lYHFTefYTxhFqtBqFmPhiyt94Y6F+lTlINuowaIoFKUPHVux48N48I0p+mWl36hUE4Flx/eQ8/mDFEU8RqXCehjkbVuIP7ZU=
Message-ID: <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com>
Date: Sat, 8 Jul 2006 10:12:36 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Mike Galbraith" <efault@gmx.de>, "Greg KH" <greg@kroah.com>
Subject: Re: Opinions on removing /proc/tty?
Cc: lkml <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1152344452.7922.11.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
	 <1152344452.7922.11.camel@Homer.TheSimpsons.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/06, Mike Galbraith <efault@gmx.de> wrote:
> On Fri, 2006-07-07 at 22:56 -0400, Jon Smirl wrote:
> > Does anyone use the info in /proc/tty? The hard coded device names
> > aren't compatible with udev's ability to rename things.
> >
> > There also doesn't appear to be any useful info in the drivers portion
> > that isn't already available in sysfs. I can add some code to make a
> > list of registered line disciplines appear in sysfs.
> >
> > Does anyone have a problem with deleting /proc/tty if ldisc enum
> > support is added to sysfs?
>
> ps uses /proc/tty/drivers, so some coordination would be needed.

Greg, I just looked at the source for ps and it has a bunch of fixed
code for turning major/minor into /dev/name.  Isn't that something
udevinfo should be doing? But looking at the help for udevinfo I don't
see any way to turn a major/minor into /dev/name. The altermative
seems to be search /dev looking for the right device node.

-- 
Jon Smirl
jonsmirl@gmail.com
