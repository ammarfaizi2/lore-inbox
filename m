Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSEGLla>; Tue, 7 May 2002 07:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSEGLl3>; Tue, 7 May 2002 07:41:29 -0400
Received: from imladris.infradead.org ([194.205.184.45]:45061 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315413AbSEGLl2>; Tue, 7 May 2002 07:41:28 -0400
Date: Tue, 7 May 2002 12:41:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Osamu Tomita <tomita@cinet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE CD-ROM PIO mode
Message-ID: <20020507124109.A32573@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Osamu Tomita <tomita@cinet.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <3CD79586.63E17164@cinet.co.jp> <3CD7A500.8030509@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 11:57:20AM +0200, Martin Dalecki wrote:
> > @@ -962,7 +962,7 @@
> >  
> >  	/* First, figure out if we need to bit-bucket
> >  	   any of the leading sectors. */
> > -	nskip = MIN(rq->current_nr_sectors - bio_sectors(rq->bio), sectors_to_transfer);
> > +	nskip = MIN((int)(rq->current_nr_sectors - bio_sectors(rq->bio)), sectors_to_transfer);

What about a s/MIN/min/g in the idea driver to easily catch such bugs?

