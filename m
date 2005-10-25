Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbVJYHE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbVJYHE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVJYHE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:04:56 -0400
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:22032 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751476AbVJYHEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:04:55 -0400
To: viro@ftp.linux.org.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1EUHni-0006ue-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 25 Oct 2005 07:56:46 +0200)
Subject: Re: [PATCH 0/8] FUSE improvements + VFS changes
References: <E1EU5RZ-0005qg-00@dorka.pomaz.szeredi.hu> <20051025042728.GK7992@ftp.linux.org.uk> <E1EUHni-0006ue-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EUIr7-0006zX-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Oct 2005 09:04:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The limitations are:
> > > 
> > >   1) open("foo", O_CREAT | O_WRONLY, 0444) or similar won't work
> > > 
> > >   2) ftruncate on a file not having write permission (but file opened
> > >      in write mode) will fail
> > > 
> > >   3) statfs() cannot return different values based on the path within
> > >      a filesystem
> > 
> >     4) mass of a body cannot vary depending on the way it's turned.
> > 
> > Horrible limitations, all of them...
> 
> Troll.
> 
> We have solution for 1-3, what's your's for 4?

And in case you're wondering, 1-2 are mandated by SUS, and obscure
programs like "cp" depend on 1) for example.  So it's not as if these
limitations were all that fair.

Miklos
