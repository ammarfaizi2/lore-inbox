Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWJQWLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWJQWLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWJQWLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:11:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27096 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750702AbWJQWLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:11:52 -0400
Subject: Re: VCD not readable under 2.6.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com>
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
	 <1161040345.24237.135.camel@localhost.localdomain>
	 <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 23:38:52 +0100
Message-Id: <1161124732.5014.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 20:16 +0200, ysgrifennodd wixor:
> Hmm.... so this is more like audio CD with separate tracks and no data
> track than like film on DVD? OK then, but how does xine tell kernel

Yes. To make video fit the mpeg video stream is encoded without all the
error correction. There may or may not be multiple tracks, each is a
chapter in the film basically.

> "give me video tracks"? Is there some magic switch_to_video ioctl on
> cdrom devices or what? And should the dd test fail with kernel errors

There are ioctls for getting sectors in non data format (just like for
reading audio bitstreams to play them).

Now where it all gets weirder is that some forms of VCD (especially the
ones for philips short lived interactive stuff) have an ISO file system
on them but where sector numbers in the file system for video blocks
point to blocks that are not 2K data blocks but mpeg blocks that the
file system layer can't handle, so a VCD disk can appear mountable and
the like.

Alan

