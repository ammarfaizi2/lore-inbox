Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265001AbRGBQ1A>; Mon, 2 Jul 2001 12:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbRGBQ0v>; Mon, 2 Jul 2001 12:26:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57354 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265001AbRGBQ0g>; Mon, 2 Jul 2001 12:26:36 -0400
Subject: Re: [RFC] I/O Access Abstractions
To: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 2 Jul 2001 17:20:26 +0100 (BST)
Cc: dhowells@redhat.com (David Howells), jes@sunsite.dk (Jes Sorensen),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        arjanv@redhat.com
In-Reply-To: <17538.994090656@redhat.com> from "David Woodhouse" at Jul 02, 2001 05:17:36 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15H6R1-00066U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dhowells@redhat.com said:
> >  I think the second #define should be:
> > 	#define res_readb(res, adr) readb(res->start+adr)
> > for consistency. 
> 
> You're right that it should be consistent. But it doesn't really matter
> whether we pass an offset within the resource, or whether we continue to

The question I think being ignored here is. Why not leave things as is. The
multiple bus stuff is a port specific detail hidden behind readb() and friends.

On the HP PA32 its already hiding controller number encodings and generating
multiple cycles under spinlocks for PCI I/O space and the devices dont know
about it

