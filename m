Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSLAJxe>; Sun, 1 Dec 2002 04:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSLAJxe>; Sun, 1 Dec 2002 04:53:34 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:25099 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261574AbSLAJxe>; Sun, 1 Dec 2002 04:53:34 -0500
Date: Sun, 1 Dec 2002 11:00:57 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: PDC20268 in current -ac [Re: Problem with via82cxxx and vt8235]
Message-ID: <20021201100057.GA24642@louise.pinerecords.com>
References: <200211300129.32580.black666@inode.at> <1038667380.17209.2.camel@irongate.swansea.linux.org.uk> <200211302227.23253.black666@inode.at> <1038710862.18752.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038710862.18752.2.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Try the -ac tree firstly
> > 
> > Thanks Alan, now dma works perfect!
> > How come this code isn't in the official 2.4.20 kernel?
> 
> Because its still getting a final polish - with luck it will be in
> 2.4.21

I'm still having problems with dma on the secondary channel of my
PDC20268.  Channel 1 is ok.

# hdparm -Iv /dev/hdg| grep '*u'
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

# hdparm -X68 /dev/hdg

/dev/hdg:
 setting xfermode to 68 (UltraDMA mode4)

(no errors logged)

# hdparm -Iv /dev/hdg| grep '*u'
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

There's no such problem w/ 2.4.20 vanilla.

-- 
Tomas Szepe <szepe@pinerecords.com>
