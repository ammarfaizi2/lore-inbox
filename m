Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWIWXYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWIWXYV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 19:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWIWXYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 19:24:20 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5073 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750912AbWIWXYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 19:24:20 -0400
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060923225947.GF21187@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl>
	 <200609221328.58504.rjw@sisk.pl>
	 <1158963526.5106.42.camel@nigel.suspend2.net>
	 <200609240018.47017.rjw@sisk.pl>
	 <1159051787.7324.11.camel@nigel.suspend2.net>
	 <20060923225947.GF21187@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 09:24:16 +1000
Message-Id: <1159053857.7324.15.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2006-09-24 at 00:59 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > We could use a regular (non-swap) file like this but that would require us to
> > > > > use some dangerous code (ie. one that writes directly to blocks belonging to
> > > > > certain file bypassing the filesystem).  IMHO this isn't worth it, provided
> > > > > the kernel's swap-handling code can do this for us and is known to work. ;-)
> > > > 
> > > > It's not that dangerous once you debug it.
> > > 
> > > Certainly.  Still, let me repeat: if there is some code that does pretty much
> > > the same and has _already_ been debugged, I prefer using it to writing some
> > > new code, debugging it etc.
> > 
> > Look at Suspend2 then. I know you won't want it in exactly that form,
> > but it's there and have been tested and debugged.
> 
> Well, but any testing/debugging would have to be invalidated for a
> merge, sorry. suspend2 has diverged too much.
> 
> "normal files" are not big priority for us, and you could probably do
> them in userland just now.... Anyway, diff -u for kernel or preferably
> for uswsusp parts would be welcome.
> 
> Telling us how much suspend2 rocks with each and every mail... is not
> that welcome. 

That's not what I was doing. I was saying that Rafael could, if he
wanted, at least look at how Suspend2 has done it and use that (if he
thinks its helpful) as a basis for improving or whatever. If he does
essentially the same thing for swsusp, he could again look at suspend2
loops etc to help in double checking his algorithm and so on.

Regards,

Nigel

