Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752678AbVHGURM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbVHGURM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbVHGURM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:17:12 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:9955 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752678AbVHGURL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:17:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JEI3L5Aj/mw+O3u5uhxiuwmHMWFkiVDlUeZmkvx0U/qNfGiHSoXaE3p6SaLlIwrm8MkqPnN6HldrBW/8q7e8j7+3t2gEZ9aCS2qKUKlHJ04jOutmnM4mWQlKcWNzlqD3Jd8C0JMmwmwAgJgiUfNAjFyyGne4Y5H2H4wqDKNybL8=
Message-ID: <9e4733910508071317a8f0eb6@mail.gmail.com>
Date: Sun, 7 Aug 2005 16:17:09 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050807184756.GA1024@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726015401.GA25015@kroah.com>
	 <20050728190352.GA29092@kroah.com>
	 <9e47339105072812575e567531@mail.gmail.com>
	 <200507282310.23152.oliver@neukum.org>
	 <9e47339105072814125d0901d9@mail.gmail.com>
	 <20020101075339.GA467@openzaurus.ucw.cz>
	 <9e47339105080506325d93f431@mail.gmail.com>
	 <20050807184756.GA1024@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > > > > Could you tell me why you don't just fail the operation if malformed
> > > > > input is supplied?
> > > >
> > > > Leading/trailing white space should be allowed. For example echo
> > > > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > > > than to teach everyone to use -n.
> > >
> > > Please, NO! echo -n is the right thing to do, and users will eventually learn.
> > > We are not going to add such workarounds all over the kernel...
> >
> > It is not a work around. These are text attributes meant for human
> > use.  Humans have a hard time cleaning up things they can't see. And
> > the failure mode for this is awful, your attribute won't set but
> > everything on the screen looks fine.
> 
> Kernel is not a place to be user friendly. Or do you propose stripping whitespace
> for open(), too? File called "foo.txt    " certainly *is* going to be confusing, but it should be allowed at kernel level.

open is not made for human use, it is used by programs and only
indirectly by humans. sysfs variables are used by directly humans.

> 
> Now... echo foo > /sys/var does not properly report errors. Thats bad, but it needs to
> be fixed in bash.

It is going to take a lot more code to return an error that a
parameter didn't match because of extra white space that it would take
to simply remove the whitespace.

> --
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
