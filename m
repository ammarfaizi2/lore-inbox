Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBFRhe>; Tue, 6 Feb 2001 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbRBFRhZ>; Tue, 6 Feb 2001 12:37:25 -0500
Received: from zeus.kernel.org ([209.10.41.242]:52174 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129177AbRBFRhG>;
	Tue, 6 Feb 2001 12:37:06 -0500
Date: Tue, 6 Feb 2001 17:34:37 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anders Eriksson <aer-list@mailandnews.com>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: sync & asyck i/o
Message-ID: <20010206173437.A19836@redhat.com>
In-Reply-To: <200102061424.PAA32284@hell.wii.ericsson.net> <E14Q9U2-0005gX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Q9U2-0005gX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 06, 2001 at 02:52:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 02:52:40PM +0000, Alan Cox wrote:
> > According to the man page for fsync it copies in-core data to disk 
> > prior to its return. Does that take async i/o to the media in account? 
> > I.e. does it wait for completion of the async i/o to the disk?
> 
> Undefined. 

> In practice some IDE disks do write merging and small amounts of write
> caching in the drive firmware so you cannot trust it 100%. 

It's worth noting that it *is* defined unambiguously in the standards:
fsync waits until all the data is hard on disk.  Linux will obey that
if it possibly can: only in cases where the hardware is actively lying
about when the data has hit disk will the guarantee break down.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
