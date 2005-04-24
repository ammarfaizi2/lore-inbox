Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVDXVQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVDXVQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVDXVQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:16:17 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:48281 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262431AbVDXVQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:16:09 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Sun, 24 Apr 2005 22:06:16 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DPoRz-0000Y0-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 23:15:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I believe the point is:
> > > 
> > >    1. Person is logged from client Y to server X, and mounts something on
> > >       $HOME/mnt/private (that's on X).
> > > 
> > >    2. On client Y, person does "scp X:mnt/private/secrets.txt ."
> > >       and wants it to work.
> > > 
> > > The second operation is a separate login to the first.
> > 
> > Solution?
> 
> ... is the same as for the same question with "set of mounts" replaced
> with "environment variables".

No.  You can't set "mount environment" in scp.

Otherwise your analogy is nice, but misses a few points.  The usage of
mounts that we are talking about is much more dynamic than usage of
environment variables.  You wouldn't want to set an environment
variable in all your shells just to access a remote system though
sshfs for example.  It _is_ possible (except the ftp, scp case) but
_very_ inconvenient.

I ask again, what solution would you suggest?

Thanks,
Miklos
