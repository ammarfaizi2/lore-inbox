Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRBVRVN>; Thu, 22 Feb 2001 12:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129494AbRBVRUy>; Thu, 22 Feb 2001 12:20:54 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:60397 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S129464AbRBVRUr>; Thu, 22 Feb 2001 12:20:47 -0500
Date: Thu, 22 Feb 2001 18:20:42 +0100
From: Christoph Baumann <baumann@kip.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with DMA buffer (in 2.2.15)
Message-ID: <20010222182042.A9968@kip.uni-heidelberg.de>
In-Reply-To: <20010222172458.A9717@kip.uni-heidelberg.de> <3A95409D.85E89D95@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A95409D.85E89D95@berlin.de>; from n.roos@berlin.de on Thu, Feb 22, 2001 at 05:38:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 05:38:53PM +0100, Norbert Roos wrote:
> Christoph Baumann wrote:
> 
> > is to do this in steps of PAGE_SIZE. What I'm looking for is a kernel routine
> > to force the mapping of previous unmapped pages. Browsing through the source
> > in mm/ I found make_pages_present(). Could this be the solution? I hadn't the
> 
> Have you already looked at mlock(2)?

Well I would have done all this (mlock, alloc buffer in kernel space and map it to user space etc.). But the critical issue is that all should be code compatible to Win (ducking away...). The API under Win allows chain DMA from user space
so the program which was initially developed under Win uses this feature. My
module needs to jump in to support this. Another problem is that the buffer
is often reallocated. 

Christoph

-- 
**********************************************************
* Christoph Baumann                                      *
* Kirchhoff-Institut für Physik - Uni Heidelberg         *
* Mail: baumann@kip.uni-heidelberg.de                    *
* Phone: ++49-6221-54-4329                               *
**********************************************************

