Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271684AbRHUQKv>; Tue, 21 Aug 2001 12:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271725AbRHUQKm>; Tue, 21 Aug 2001 12:10:42 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:45696
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S271684AbRHUQK1>; Tue, 21 Aug 2001 12:10:27 -0400
Date: Tue, 21 Aug 2001 12:10:35 -0400
From: Chris Mason <mason@suse.com>
To: David Madore <david.madore@ens.fr>, linux-kernel@vger.kernel.org
Subject: Re: Weird file corruption (448 bytes): FS? RAM?
Message-ID: <34250000.998410235@tiny>
In-Reply-To: <20010821175441.A26624@clipper.ens.fr>
In-Reply-To: <20010821175441.A26624@clipper.ens.fr>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, August 21, 2001 05:54:41 PM +0200 David Madore
<david.madore@ens.fr> wrote:

> Hi.
> 
> This is to report an almost paranormal phenomenon :-)
> 
> A few days ago I posted to this list because I had noticed a one-bit
> corruption of one of my files.  This corruption was actually due to a
> defective RAM, as memtest86 showed.  But memtest86 showed that only
> *one* bit was wrong.  Now I am running Linux with "mem=" parameters
> that tell it not to use the page with the defective bit.
> 
> Now I have just observed another file corruption.  This one is more
> severe: 448 contiguous bytes were corrupted (details follow).  This
> time I'm inclined to think the RAM is not to blame (448 defective
> *bytes* do not go unnoticed), but the filesystem (ReiserFS).  However,
> I would like expert opinion on this.  I would be grateful for any
> ideas or suggestions.
> 
Hmmm, I don't know of any reiserfs bugs in 2.4.6 that look like this.  You
might have found a new one, but I think it is more likely a 1 bit error in
the in-ram struct telling reiserfs which block to read in.  If it reads the
wrong block, you've got big problems.

It will be hard to debug for sure until we are positive all the ram in the
box is good.

-chris

