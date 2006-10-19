Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946531AbWJSVmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946531AbWJSVmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946535AbWJSVmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:42:38 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:26064 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1946531AbWJSVmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:42:37 -0400
Date: Thu, 19 Oct 2006 23:39:31 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: 7eggert@gmx.de
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kronos.it@gmail.com, ismail@pardus.org.tr, 7eggert@gmx.de
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <4537f093.TLaIyXNS8h2a3uF9%Joerg.Schilling@fokus.fraunhofer.de>
References: <771eN-VK-9@gated-at.bofh.it>
 <771yn-1XU-65@gated-at.bofh.it> <E1GZy4L-00015O-AV@be1.lrz>
 <453644f3.0BzwxliMKAw+rSMj%Joerg.Schilling@fokus.fraunhofer.de>
 <Pine.LNX.4.58.0610182023100.2145@be1.lrz>
 <4536b8dc.nfxUMeg8jVJ9WF95%Joerg.Schilling@fokus.fraunhofer.de>
 <Pine.LNX.4.58.0610192256460.2316@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0610192256460.2316@be1.lrz>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:

> > > Exactly that's why I'd ignore the on-disk "inode number" and instead use
> > > the generated one untill someone comes along with a clever idea to fix
> > > the issue or can show that it's mostly hermless.
> > 
> > I could understand you in case that Linux would do some basic consistency checks
> > in the iso-9660 code already.....
>
> ISO9660-over-NFS is no big usecase, linked files on CD aren't common and 
> the current code just won't benefit from hardlinks. Therefore I don't see 
> a compelling reason to use this feature without first thinking about 
> possible attacks.

It looks like you did never really think about the problem or that you just 
don't know what you are talking about :-(

A typical UNIX standard installation has more than 3000 hard linked file name
entries in the root filesystem. There are many people who like to backup their 
root filesystem via mkisofs and all life CDs and install CDs depend on hard 
linked files.

But this seems to be a frequent way of dealing with implementation deficits:
define the problem to be not existant....


> Even if there are more holes to be plugged, punching even more holes 
> doesn't help. Instead, we should hope that someone finds the time to
> plug these holes and praise him when he comes.

It seems that you did not think about the problem...

Wrong inode numbes do not open holes, they just create a garbage in garbage out
behavior, but they will not cause the OS to panic. 

The unfixed bugs in the Linux iso-9660 implementation on the other side allow 
me to create a CD that causes Linux to panic without taking me a long time.

> > Show me another program besides mkisofs that implements inode numbers _and_ does
> > it wrong.
>
> My hacked mkisofs, which I'll use to r00t you all and gain world domination.

This is just a junk statement, describe what you believe than can be done...

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
