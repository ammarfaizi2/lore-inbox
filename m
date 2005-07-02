Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVGBOub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVGBOub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 10:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVGBOub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 10:50:31 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:9732 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261180AbVGBOuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 10:50:24 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050701180415.GA7755@janus> (message from Frank van Maarseveen
	on Fri, 1 Jul 2005 20:04:15 +0200)
Subject: Re: FUSE merging?
References: <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus>
Message-Id: <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 02 Jul 2005 16:49:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm not saying this is a problem, but also I don't see any
> > overwhelming reason to not allow user mounts over non-leaf
> > directories.
> 
> All things considered I'd still prefer forbidding FUSE mounts on non-leaf
> dirs. For name space sanity. And it may be easier to get the whole thing
> accepted:
> 
> -	One could argue that the existing name space is extended rather than
> 	changed [for a subset of processes], what Al Viro seems to reject.
> -	The processes which cannot be ptraced/sent a signal by the mount
> 	owner are not "forced" to traverse the FUSE mount for the sake of
> 	name space invariancy, with all associated security problems: they
> 	can see everything up to the leaf node of all the usual mounts.
> 
> But put otherwise: is there a compelling reason to permit FUSE mounts on
> non-leaf nodes?

Not really.  Maybe it does have some uses, but I'm not aware of any.

But I don't think it would matter in the acceptance of the mount
hiding patch, since that patch was not rejected on the basis of what
FUSE would use it for, rather for the general philosophy of not
allowing namespace differences based on user id.

> Can FUSE mount on a file like NFS?

Yes.

> What is your opinion about replacing the ptrace check by a signal check
> (later on, no hurry)?

Maybe.  You'd still have to convince me, that signals sent to suid
programs are not a security problem.

Miklos
