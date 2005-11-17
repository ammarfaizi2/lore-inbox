Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVKQRU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVKQRU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVKQRU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:20:57 -0500
Received: from web50112.mail.yahoo.com ([206.190.39.149]:20641 "HELO
	web50112.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932440AbVKQRU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:20:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e8caNDvTYVpJfMgYpmX5TAsyFVqujFCGKlCy6U23SVy9F7U9DIWoKVIVarQ3ASuPPuthix1/2RXECCWKIfKv4mtK00Y4GvVgfajaCqfjBPQlCHuB7sWvUB8f8/bx84uuzCODyWXjd4DaHnjrRoLWFHHKDL2kzzToL6yp9x6afB4=  ;
Message-ID: <20051117172053.87207.qmail@web50112.mail.yahoo.com>
Date: Thu, 17 Nov 2005 09:20:53 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [RFC] EDAC and the sysfs
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051117070516.GB20760@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Greg KH <greg@kroah.com> wrote:

> On Tue, Nov 15, 2005 at 04:26:38PM -0800, Doug
> Thompson wrote:

> > My question is:  Should I remove entirely my old
> > /proc/sys/mc sysctl tree? Or still maintain the
> > aliases there (which seems weird)? 
> 
> That would be wierd, just drop the sysctl stuff.
> 
> > If I do that, then /etc/sysctl.conf will no longer
> > allow for setting things up there.
> 
> True.
> 
> > Is there going to be a similiar functionality as
> > /etc/sysctl.conf for those items we place in
> sysfs, in
> > the future?
> 
> If you want to write one, sure :)

Good idea. Seems I have hit the edge of current
features. That's is good for now there is another food
item for a TODO list.

> 
> But you can just probably use a udev rule to
> initialize your things
> properly, that's what all of the distros are now
> using.

Ok. That's another area for me to research. edac does
not have any /dev/ entries, just the files and
controls previous mentioned. 

So, from your comment then, udev has some mechanism to
set controls in sysfs?


> 
> > PS. These questions on sysfs seem a perfect food
> > stream for your 'HOWTO do kernel development'.
> Trying
> > to do new entries in sysfs has been a painstaking
> > adventure. After googling the web for info, it
> > definitely has been a bit thin on information on
> sysfs
> > at the level I am seeking.
> 
> sysfs and the driver model are woefully
> underdocumented.  Right now, I'd
> recommend the Linux Device Drivers, third edition,
> free online if you
> don't want to buy it, for anyone doing any driver
> core stuff.  It has a
> whole chapter that is the most up-to-date and the
> best description I've
> seen so far.

Yes, I have LDD 3rd and it is good. I have also have
Robert Love's book and it has some good stuff on the
device model and sysfs, but I assume since the whole
feature is fairly new its documentation and
understanding are still in the nursery.

I also came across Patrick Mochel's paper given at
Linux Symposium in June 2005. That helped.

>From the src on the machinecheck currently in sysfs, I
see it implements the 'subsystem' feature of sysfs.
>From that code I see the pattern I can use.

> 
> But even then, it is out of date, due to api
> changes, sorry.
> 
> thanks,
> 
> greg k-h
> 

at least there is some docs AND some people to ask
questions to.

thanks

doug t



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

