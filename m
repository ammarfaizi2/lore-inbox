Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270609AbRHNM43>; Tue, 14 Aug 2001 08:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270612AbRHNM4T>; Tue, 14 Aug 2001 08:56:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27920 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270609AbRHNM4H>; Tue, 14 Aug 2001 08:56:07 -0400
Subject: Re: Swapping for diskless nodes
To: pavel@suse.cz (Pavel Machek)
Date: Tue, 14 Aug 2001 13:57:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), abali@us.ibm.com (Bulent Abali),
        dws@dirksteinberg.de (Dirk W. Steinberg),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20010811011329.C55@toy.ucw.cz> from "Pavel Machek" at Aug 11, 2001 01:13:29 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Wdla-00018V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ultimately its an insoluble problem, neither SunOS, Solaris or NetBSD are
> > infallible, they just never fail for any normal situation, and thats good
> > enough for me as a solution
> 
> Oops,  really? And if I can DoS such machine with ping -f (to eat atomic
> ram)? And what are you going to tel your users? "It died so reboot"?

For the simplistic case you can stop queueing data to user sockets but that
isnt neccessarily a cure - it can lead to bogus OOM by preventing progress
of apps that would otherwise read a packet then exit.

The good example of the insoluble end of it is a box with no default route
doing BGP4 routing with NFS swap. Now thats an extremely daft practical 
proposition but it illustrates the fact the priority ordering is not known
to the kernel
