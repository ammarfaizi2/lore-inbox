Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289379AbSBJJLu>; Sun, 10 Feb 2002 04:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289376AbSBJJKX>; Sun, 10 Feb 2002 04:10:23 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:7437 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S289375AbSBJJKF>; Sun, 10 Feb 2002 04:10:05 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [V4L] [PATCH/RFC] videodev.[ch] redesign
Date: 10 Feb 2002 08:59:45 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna6cdk1.ret.kraxel@bytesex.org>
In-Reply-To: <20020209194602.A23061@bytesex.org> <200202100203.g1A23To32387@devserv.devel.redhat.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1013331585 28164 127.0.0.1 (10 Feb 2002 08:59:45 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > It also provides a ioctl wrapper function which handles copying the
> > ioctl args from/to userspace, so we have this at one place can drop all
> > the copy_from/to_user calls within the v4l device driver ioctl handlers.
> > 
> > Comments?
>  
>  I'm not sure 2.4 should change but for 2.5 this is absolutely bang on
>  perfect

For 2.5 I want switch over to using file_operations completely and drop
the old stuff.  Thus 2.4 should provide both old+new way to handle
stuff:  The old one for backward compatibility and the new one to allow
backporting 2.5.x drivers to 2.4 ...

Yesterday I've booted a 2.5.x kernel the first time and managed to make
bttv work there.  2.5.x version of the will follow ...

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
