Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263146AbTDBTDv>; Wed, 2 Apr 2003 14:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbTDBTDv>; Wed, 2 Apr 2003 14:03:51 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22937 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263144AbTDBTDm>; Wed, 2 Apr 2003 14:03:42 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 2 Apr 2003 21:19:00 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: videobuf update
Message-ID: <20030402191900.GA27002@bytesex.org>
References: <20030402163647.GA24583@bytesex.org> <20030402190649.A1091@infradead.org> <20030402183544.GA26132@bytesex.org> <20030402193635.A1462@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402193635.A1462@infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 07:36:36PM +0100, Christoph Hellwig wrote:
> > Because the 2.5.x code doesn't compile on 2.4.x, thus there are version
> > #ifdefs in my device driver tarballs.  You just don't see that because
> > some perl magic filteres out the 2.4 code when submitting patches for
> > 2.5.x (and visa versa ...).  If you fetch the tarballs from bytesex.org
> > you'll see the #ifdefs in the driver code.
> 
> So what about stripping #include <linux/version.h> in your script aswell? :)

In video-buf.c it can likely deleted without side effects, but just
removing it unconditionally everythere likely doesn't work because my
drivers use the KERNEL_VERSION() macro for the device driver version as
well (see drivers/media/video/bttvp.h for example).

  Gerd

-- 
Michael Moore for president!
