Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288827AbSAUWzG>; Mon, 21 Jan 2002 17:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288842AbSAUWy4>; Mon, 21 Jan 2002 17:54:56 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:33437 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288827AbSAUWyj>; Mon, 21 Jan 2002 17:54:39 -0500
Date: Mon, 21 Jan 2002 17:54:36 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020121175436.B11889@devserv.devel.redhat.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201171855.g0HIt1314492@devserv.devel.redhat.com> <200201181212.g0ICCGq14563@bliss.uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201181212.g0ICCGq14563@bliss.uni-koblenz.de>; from krienke@uni-koblenz.de on Fri, Jan 18, 2002 at 01:12:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 01:12:16PM +0100, Rainer Krienke wrote:
> On Thursday, 17. January 2002 19:55, Pete Zaitcev wrote:
> >
> > I am surprised anyone is interested. If you need more than 800
> > mounts I think your system planning may be screwed.

> ease administration we chose the approach to mount each user directory 
> direcly (via automount configured by NIS) on a NFS client where the user 
> wants to access his data. The most 
> important effect of this is, that each users directory is always reachable 
> under the path /home/<user>.

This is not an unusual setup, but normally servers and
workstations do not need to mount enormous number of volumes.
So, I did the same because it's very useful, but I prohibited
~/.forward. Instead, requests for vacation messages were
submitted centrally and processed with the help of /etc/aliases
and automation scripts. This way mailing loops were under control,
and, as a side effect, sending something to a mailing list
did not require the mailserver to mount a gazillion of home
directories in order to fetch ~/.forward for each recipient.

> So I think it would be really good to have at least the option to have more 
> than 256 NFS mounts even if one has to use unsecure ports for this purpose. 

Sure... The thing is, the 1279 mounts that I did is not
even close to being adequate to combat .forward or something
like separate mounted mail spools for large ISPs. You
really need 10,000 of mounts, at which point the whole idea of
anonymous device numbers falls apart.

-- Pete
