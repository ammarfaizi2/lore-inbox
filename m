Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319041AbSIDEOW>; Wed, 4 Sep 2002 00:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319044AbSIDEOW>; Wed, 4 Sep 2002 00:14:22 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:27661 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319041AbSIDEOW>;
	Wed, 4 Sep 2002 00:14:22 -0400
Date: Tue, 3 Sep 2002 21:17:05 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Message-ID: <20020904041705.GC3739@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D6821CC2C@AUSXMPC122.aus.amer.dell.com> <E17mOfS-0005nm-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17mOfS-0005nm-00@starship>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 03:09:12AM +0200, Daniel Phillips wrote:
> On Wednesday 04 September 2002 02:54, Matt_Domsch@Dell.com wrote:
> > > How about providing an example of how you'd export the root 
> > > via driverfs,
> > > with a view to educating those of us who are still don't have 
> > > much of a clue how driverfs fits in with big picture?
> > 
> > Right now that includes me which is why I used proc for now. :-)
> 
> Maybe we should prevail upon the driverfs axis to provide some guidance.

Sweet, we're an axis now!  That's much better than the other terms Pat
and I have been called in the past...  And everyone knows what's the
next size jump up from axis :)

So here's how driverfs fits into the big picture in one sentance:

	Anything that does not have to do with processes 
	will go into driverfs.

So in this example, we are exporting a number of boot devices as the
bios told us, so apply the rule stated above, and determine if it should
go into /proc or not[1].

thanks,

greg k-h

[1]  Yes, it's still a bit difficult to figure how to add files to
driverfs, if you aren't starting with a "struct device" or "struct
device_driver", but I have seen some very nice documentation on how to
do it properly written by Pat involving a wonderful example of beer, and
I'm sure that once he gets back into internet connectivity range, he'll
be updating it and adding it to the Documentation directory.  That
should be by the end of the week or so.
