Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbRGXNDx>; Tue, 24 Jul 2001 09:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRGXNDn>; Tue, 24 Jul 2001 09:03:43 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:56586 "EHLO dcs.qmw.ac.uk")
	by vger.kernel.org with ESMTP id <S267516AbRGXNDe>;
	Tue, 24 Jul 2001 09:03:34 -0400
Date: Tue, 24 Jul 2001 14:03:39 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>,
        <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
Subject: Re: nfs weirdness
In-Reply-To: <15197.21462.625678.700365@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.33.0107241353170.17270-100000@nick.dcs.qmw.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 20:54 +1000 Neil Brown wrote:

>knfsd exports filesystems, or parts there-of.  It doesn't export
>'parts of the visible namespace'.
>
>If you ask to export "/windows" and nothing is mounted on "/windows",
>then you are asking to export part of the root filesystem starting at
>"/windows".  If you subsequently mount something on /windows, then you
>haven't asked for that to be exported so it won't be, and mountd will
>get confused.
>You should always mount filesystems before trying to export them.

ISTR I had a setup where I had autofs mount some external drives and knfsd
export them, under Debian woody some months ago, and it all worked kind of
how I might expect (ie remote access could cause *my* volumes to be
mounted when I hadn't). Now I'm running RedHat and knfsd (or some init
script) mounts all my autofs volumes before exporting them.

I'm not grumbling 'cos everything's on journalling filesystems now :))

Matt

