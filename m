Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319112AbSHWTHZ>; Fri, 23 Aug 2002 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319113AbSHWTHZ>; Fri, 23 Aug 2002 15:07:25 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:13573 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319112AbSHWTHY>; Fri, 23 Aug 2002 15:07:24 -0400
Date: Fri, 23 Aug 2002 20:11:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcus Alanen <maalanen@ra.abo.fi>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.5] vmalloc.c error path fixes
Message-ID: <20020823201133.A26160@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>, Marcus Alanen <maalanen@ra.abo.fi>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208202022100.16857-100000@tuxedo.abo.fi> <3D628BF5.26FBE772@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D628BF5.26FBE772@zip.com.au>; from akpm@zip.com.au on Tue, Aug 20, 2002 at 11:35:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 11:35:33AM -0700, Andrew Morton wrote:
> > of the diff fix a spinlock being held if an error occurs in
> > map_vm_area, and the last part fixes the error path of __vmalloc.
> 
> Certainly agree on the first chunk.  Listen to the old guy: "Thou
> shalt not have more than one return statement per function".
> 
> Second chunk looks good too, but perhaps there's another way of doing
> it.  The 2.5.31 code just tossed it all at vfree.  Perhaps hch can
> comment?

The code looks fine - I missed that error checking.  A little nitpick:
either remove the comment inn the last chunk as it's obvious what we
are doing or at least make it fit an ansi terminal.
