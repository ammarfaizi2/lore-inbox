Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSAUMla>; Mon, 21 Jan 2002 07:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSAUMlL>; Mon, 21 Jan 2002 07:41:11 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:16815 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S285593AbSAUMkw>; Mon, 21 Jan 2002 07:40:52 -0500
Message-Id: <200201211240.g0LCef201970@bliss.uni-koblenz.de>
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Mon, 21 Jan 2002 13:40:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: nfs@lists.sourceforge.net
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201171855.g0HIt1314492@devserv.devel.redhat.com>
In-Reply-To: <200201171855.g0HIt1314492@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 17. January 2002 19:55, Pete Zaitcev wrote:
> >[from linux-kernel]
> > I have to increase the number of anonymous filesystems the kernel can
> > handle and found the array unnamed_dev_in_use fs/super.c and changed the
> > array size from the default of 256 to 1024. Testing this patch by
> > mounting more and more NFS-filesystems I found that still no more than
> > 800 NFS mounts are possible. One more mount results in the kernel saying:
> >
> > Jan 17 14:03:11 gl kernel: RPC: Can't bind to reserved port (98).
> > Jan 17 14:03:11 gl kernel: NFS: cannot create RPC transport.
> > Jan 17 14:03:11 gl kernel: nfs warning: mount version older than kernel
>
> I did that. You also need a small fix to mount(8) that adds
> a mount argument "-o nores". I've got an RPM at my website.
>
> Initially I did a sysctl, but Trond M. asked for a mount
> argument, in case you have to mount from several servers,
> some of which require reserved ports, some do not.
> Our NetApps work ok with non-reserved ports on clients.
>

Anyone has the patch Pete mentioned above for mount. He mailed the kernel 
patches but I am unable to find the mount fix he talked about.

Thanks Rainer
-- 
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz, 		   http://www.uni-koblenz.de/~krienke
Rechenzentrum,                     Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
