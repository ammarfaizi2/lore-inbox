Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288130AbSATKe6>; Sun, 20 Jan 2002 05:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288149AbSATKet>; Sun, 20 Jan 2002 05:34:49 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:2863 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S288130AbSATKef>; Sun, 20 Jan 2002 05:34:35 -0500
Message-Id: <200201201033.g0KAXfw20121@robotnik.krienke.org>
Content-Type: text/plain; charset=US-ASCII
From: Rainer krienke <rainer@krienke.org>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Sun, 20 Jan 2002 11:33:40 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201181212.g0ICCGq14563@bliss.uni-koblenz.de> <a29tms$s9v$1@cesium.transmeta.com>
In-Reply-To: <a29tms$s9v$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Januar 2002 20:40 schrieb H. Peter Anvin:
> Followup to:  <200201181212.g0ICCGq14563@bliss.uni-koblenz.de>
> By author:    Rainer Krienke <krienke@uni-koblenz.de>
> In newsgroup: linux.dev.kernel
>
> > Now think of a setup where no user directory mounts are configured but
> > the whole directory of a NFS server with many users is exported. Of
> > course this makes things easyer for the NFS-system since only one mount
> > is needed but on the client you need to create link trees or something
> > similar so the user still can access his home under /home/<user> and not
> > something like /home/server1/<user>. Moreover even if you create link
> > trees when you issue commands like pwd you see the real path (eg
> > /server1/<user>) instead of the logical (/home/<user>). Such paths are
> > soon written into scripts etc, so that if the user is moved sometime
> > later  things will be broken.
> > You simply loose a layer of abstraction if you do not mount the users dir
> > directly. The only other solution I know of would be amd. Amd
> > automatically places a link. But since we come from the sun world, we
> > simply uses suns automounter and there were no problems up to now.
>
> This can easily be resolved with vfsbinds.  Even Sun has a specific
> syntax in their automounter to deal with this
> (server:common_root:tail).  If I ever do another autofs v3 release I
> will probably try to incorporate that via vfsbinds.
>
> 	-hpa

You mentioned, you'd probably include this in another V3 release. Does this 
mean, that V4 already can do this? What syntax is needed? What about the 
logical/physical path problem? Is this already solved by using vfsbinds in V4?

Thanks Rainer
-- 
Rainer Krienke, rainer@krienke.org
