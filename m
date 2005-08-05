Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVHESSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVHESSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVHESP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:15:56 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:52921 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262845AbVHESOP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:14:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=itVBIgqE0WEzNwxb6zASDpPbBN3UecjU7yLVAva34/KZImelZALPVghZ4BFf6ypU6HQlM++BX46tGVCJHbwSQ3322+kHhs4fa56V8faQ9SuaYCzWCgCYeup1exDUTCKIUyqc+4JBrW/HUlYLoIJt7UAJweV26Ap7x42aNAtaTlw=
Message-ID: <9e47339105080511143e01c531@mail.gmail.com>
Date: Fri, 5 Aug 2005 14:14:11 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200508052001.11442.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726015401.GA25015@kroah.com>
	 <20020101075339.GA467@openzaurus.ucw.cz>
	 <9e47339105080506325d93f431@mail.gmail.com>
	 <200508052001.11442.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> Am Freitag, 5. August 2005 15:32 schrieb Jon Smirl:
> > On 1/1/02, Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> > >
> > > > > > New, simplified version of the sysfs whitespace strip patch...
> > > > >
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
> The average user has no place poking sysfs. Root should know when
> to use -n, as should shell scripts.

So the average user never needs to change their console mode? Check
out /sys/class/graphics/fb/modes and mode.

> 
>         Regards
>                 Oliver
> 


-- 
Jon Smirl
jonsmirl@gmail.com
