Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287793AbSBKKPn>; Mon, 11 Feb 2002 05:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287770AbSBKKPd>; Mon, 11 Feb 2002 05:15:33 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:30980 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S287793AbSBKKPN>; Mon, 11 Feb 2002 05:15:13 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Feb 2002 10:55:34 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Mark McClelland <mark@alpha.dyndns.org>
Cc: video4linux-list@redhat.com, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [V4L] [PATCH/RFC] videodev.[ch] redesign
Message-ID: <20020211105534.A4745@bytesex.org>
In-Reply-To: <20020209194602.A23061@bytesex.org> <3C65EFF4.2000906@alpha.dyndns.org> <20020210101130.A28225@bytesex.org> <3C666D98.70600@alpha.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C666D98.70600@alpha.dyndns.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2002 at 04:54:48AM -0800, Mark McClelland wrote:
> OK, agreed on all points. Thanks for the clarification.
> 
> BTW, is there any chance for vmalloc() and pals to be moved to 
> videodev.c, or something higher-up?

What do you mean exactly?  bttv's memory management code, which has
been copied to various places, and which is now broken in 2.5.x due
to virt_to_bus() being gone finally?

Some of this is work-in-progress.  I'm talking to Dave to put some
helper functions to handle DMA to vmalloced memory blocks to some
sensible place within the kernel.  If someone wants to have a look
(not final yet): http://bytesex.org/patches/15_pci-2.4.18-pre8.diff

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
