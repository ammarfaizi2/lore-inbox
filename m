Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRBFSWR>; Tue, 6 Feb 2001 13:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129833AbRBFSWH>; Tue, 6 Feb 2001 13:22:07 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57308 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129830AbRBFSVx>;
	Tue, 6 Feb 2001 13:21:53 -0500
Date: Tue, 6 Feb 2001 18:18:08 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anders Eriksson <aer-list@mailandnews.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sync & asyck i/o
Message-ID: <20010206181808.I1167@redhat.com>
In-Reply-To: <20010206173437.A19836@redhat.com> <200102061424.PAA32284@hell.wii.ericsson.net> <E14Q9U2-0005gX-00@the-village.bc.nu> <20010206173437.A19836@redhat.com> <19450.981482081@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <19450.981482081@redhat.com>; from dwmw2@infradead.org on Tue, Feb 06, 2001 at 05:54:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 05:54:41PM +0000, David Woodhouse wrote:
> 
> sct@redhat.com said:
> >  Linux will obey that if it possibly can: only in cases where the
> > hardware is actively lying about when the data has hit disk will the
> > guarantee break down. 
> 
> Do we attempt to ask SCSI disks nicely to flush their write caches in this 
> situation? cf. http://www.danbbs.dk/~dino/SCSI/SCSI2-09.html#9.2.18

No, we simply omit to instruct them to enable write-back caching.
Linux assumes that the WCE (write cache enable) bit in a disk's
caching mode page is zero.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
