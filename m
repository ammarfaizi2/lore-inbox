Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVFJOVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVFJOVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVFJOVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:21:49 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:12007 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262567AbVFJOVY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:21:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ayG5Tz5t0ZKSVUy8nXO9+YHcPsNuGftMkH0Q9GggmoaBovcZgG6SGicd1gudGTLWPrxJSkyuICfvYmsGYZjZukxQ1CQljy5c2OeoO5HLeo3VcHDprB/rq9Vmt6CSWhFR5VizXIQ17BJowrTPRDHNuGnSyhpB0NYs6KlUdv2hAW0=
Message-ID: <a728f9f905061007216c38cf4c@mail.gmail.com>
Date: Fri, 10 Jun 2005 10:21:19 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: [Jfs-discussion] fsck.jfs segfaults on x86_64
Cc: jfs-discussion@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ag@m-cam.com
In-Reply-To: <1118412882.7944.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a728f9f90506100700107976f0@mail.gmail.com>
	 <1118412882.7944.6.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/05, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> On Fri, 2005-06-10 at 10:00 -0400, Alex Deucher wrote:
> > We have a large lvm2 logical volume (6.91T) which contains a JFS
> > filesystem. The volumes accessed via emulex FC HBAs connected to a
> > nexsan SAN.  There was a bug in the SAN firmware that caused the
> > primary controller to lose sync with the other controller and go down.
> >  Normally when this happens we are able to reboot the SAN and the
> > server and then run fsck on the volume, and everything is fine (on a
> > side note, we have updated the SAN firmware to fix the sync problem).
> > however, fsck now segfaults and the volume is dirty so it can't be
> > mounted. lvdisplay and vgdisplay seem to work fine displaying the
> > correct info.  Does anyone know what may be causing the problem or how
> > we can fix it?  If possible I'd like to save the data on the volumes.
> >
> > #> time fsck.jfs /dev/vg00/lvol0
> > fsck.jfs version 1.1.4, 30-Oct-2003
> 
> 1.1.4 is quite old.  Can you try a recent version of jfsutils?
> http://jfs.sourceforge.net/project/pub/jfsutils-1.1.8.tar.gz

sorry, I should have mentioned that.  we also tried 1.1.7 with the
same result.  I can try 1.1.8 too.

> 
> If that doesn't work, you can try running "fsck.jfs
> --omit_journal_replay", since it is trapping while replaying the
> journal.  If all else fails, you should be able to mount it read-only
> (mount -oro) to recover the data.

cool I'll give that a try.

Thanks!

Alex

> 
> Thanks,
> Shaggy
> --
> David Kleikamp
> IBM Linux Technology Center
> 
>
