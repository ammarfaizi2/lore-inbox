Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSGARsn>; Mon, 1 Jul 2002 13:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGARsm>; Mon, 1 Jul 2002 13:48:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8093 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316047AbSGARsi>;
	Mon, 1 Jul 2002 13:48:38 -0400
Date: Mon, 1 Jul 2002 10:45:29 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Nick Bellinger <nickb@attheoffice.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <1025134761.15055.84.camel@subjeKt>
Message-ID: <Pine.LNX.4.33.0207011033570.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That's why I think a "non-physical" tree (not under $DRIVERFS/root) is more
> > sensible in such cases.  Which is not to say it's without additional issues
> > (like how to establish/maintain driver linkages that are DAGs not single
> > parent trees) but it wouldn't require drivers to dig as deeply into lower
> > levels of their stack.  (And some network interfaces might well live in
> > such a non-physical tree, not just iSCSI...)
> > 
> 
> I am in complete agreement, from my little view of where driverfs
> currently stands a non-physical tree is going to have to happen sooner
> or later,  why not now?  

No. The physical hierarchy in driverfs is meant to be as accurate as 
possible. Yes, it's idealistic, and at some point we might have to make a 
bit of an exception. But, I refuse to break that model yet. 

	-pat

