Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSGOQka>; Mon, 15 Jul 2002 12:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSGOQk3>; Mon, 15 Jul 2002 12:40:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53004 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317536AbSGOQk2>;
	Mon, 15 Jul 2002 12:40:28 -0400
Message-ID: <3D32FB8D.6030202@mandrakesoft.com>
Date: Mon, 15 Jul 2002 12:42:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
References: <20020711230222.GA5143@kroah.com> <agtn5j$ij2$1@penguin.transmeta.com> <20020715104629.A11096@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Jul 15, 2002 at 05:38:59AM +0000, Linus Torvalds wrote:
>  > > drivers/char/agp/agpgart_be-via.c    |  151 +
>  > Ok, so is there any real _reason_ to have filenames quite this ugly?
> 
> of course not. I'll fix it up later, and send an updated patch
> with 1-2 other small changes that happened since Greg's work
> (one of the Intel backends had a subtle thinko brought forward
>  from 2.4.19rc1)
> 
>  > If you want the redundancy, duplication and profusion, please keep it
>  > shorter.  And put it at the end, so that at least filename completion
>  > works well: "via-agp.c".
>  > 
>  > Ok?
> 
> Ok, I think we can even do away with the -agp, as we're in the
> agp/ dircetory, which again seems to be pointless duplication.


modprobe is still a flat namespace :/  So it's not necessarily pointless 
duplication.  That's why I named the via82cxxx audio driver with the 
_audio suffix, to eliminate conflicts with drivers/ide/via82cxxx.c 
when/if it becomes directly modprobe-able.

	Jeff




