Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129813AbRB0WKR>; Tue, 27 Feb 2001 17:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRB0WKI>; Tue, 27 Feb 2001 17:10:08 -0500
Received: from dsl081-067-005-sfo1.dsl-isp.net ([64.81.67.5]:48142 "EHLO
	renegade") by vger.kernel.org with ESMTP id <S129813AbRB0WKE>;
	Tue, 27 Feb 2001 17:10:04 -0500
Date: Tue, 27 Feb 2001 13:56:25 -0800 (PST)
From: Zack Brown <zbrown@tumblerings.org>
Reply-To: Zack Brown <zbrown@tumblerings.org>
To: "David L. Nicol" <david@kasey.umkc.edu>
cc: linux-cluster@nl.linux.org, riel@conectiva.com.br, viro@math.psu.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will Mosix go into the standard kernel?
In-Reply-To: <3A9C1A3A.8BC1BCF2@kasey.umkc.edu>
Message-ID: <Pine.LNX.3.96.1010227134555.780R-100000@renegade>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do the Mosix folks have anything to add about possible integration into the
kernel? (should have cced them earlier, but it slipped my mind)

 On Tue, 27 Feb 2001, David L. Nicol wrote:

> Zack Brown wrote:
> > 
> > Just curious, are there any plans to put Mosix into the standard kernel,
> > maybe in 2.5, so folks could just configure it and go? it seems that the
> > number of people with more than one computer might make this a feature many
> > would at least want to try, especially if it was available as an option by
> > default. Is there anything in the Mosix folks' implementation that would
> > prevent this?
> 
> I'm not a knowledgeable person, but I've been following Mosix/beowulf/? for
> a few years and trying to keep up.
> 
> I've thought that it would be good to break up the different clustering
> frills -- node identification, process migration, process hosting, distributed
> memory, yadda yadda blah, into separate bite-sized portions.  
> 
> Centralization would be good for standardizing on what /proc/?/?/? you read to
> find out what clusters you are in, and whatis your node number there.  There
> is a lot of theorhetical work to be done.
> 
> Until then, I don't expect to see the Complete Mosix Patch Set available
> from ftp.kernel.org in its current form, as a monolithic set that does many things,
> including its Very Own Distributed File System Architecture.
> 
> If any of the work from Mosix will make it Into The Standard Kernel it will be
> by backporting and standardization.
> 
> 
> Is there a good list to discuss this on?  Is this the list?  Which pieces of
> clustering-scheme patches would be good to have? 
> 
> I think a good place to start would be node numbering.
> 
> The standard node numbering would need to be flexible enough to have one machine
> participating in multiple clusters at the same time.
> 
> /proc/cluster/....	this would be standard root point for clustering stuff
> 
> /proc/mosix would go away, become proc/cluster/mosix
> 
> and the same with whatever bproc puts into /proc; that stuff would move to
> /proc/cluster/bproc
> 
> 
> Or, the status quo will endure, with cluster hackers playing catch-up.

On Tue, 27 Feb 2001, Alexander Viro wrote:

|
|#include <std_rants/Thou_Shalt_Not_Shite_Into_Procfs>
|
|Guys, if you want a large subtree in /proc - whack yourself over the head
|until you realize that you want an fs of your own. I'll be more than
|happy to help with both parts.

Rik van Riel said:

> I know each of the cluster projects have mailing lists, but
> I've never heard of a list where the different projects come
> together to eg. find out which parts of the infrastructure
> they could share, or ...
> 
> Since I agree with you that we need such a place, I've just
> created a mailing list:
> 
>         linux-cluster@nl.linux.org
> 
> To subscribe to the list, send an email with the text
> "subscribe linux-cluster" to:
> 
>         majordomo@nl.linux.org
> 
> 
> I hope that we'll be able to split out some infrastructure
> stuff from the different cluster projects and we'll be able
> to put cluster support into the kernel in such a way that
> we won't have to make the choice which of the N+1 cluster
> projects should make it into the kernel...



-- 
Zack Brown







