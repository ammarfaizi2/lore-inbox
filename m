Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131783AbRBAU4k>; Thu, 1 Feb 2001 15:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131776AbRBAU4b>; Thu, 1 Feb 2001 15:56:31 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:8277 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131619AbRBAU4S>;
	Thu, 1 Feb 2001 15:56:18 -0500
Message-Id: <200102012056.f11Kulp21108@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@caldera.de>
cc: sct@redhat.com ("Stephen C. Tweedie"), Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org,
        "kiobuf-io-devel@lists.sourceforge.net Alan Cox" 
	<alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains 
In-Reply-To: Message from Christoph Hellwig <hch@caldera.de> 
   of "Thu, 01 Feb 2001 21:33:27 +0100." <200102012033.VAA15590@ns.caldera.de> 
Date: Thu, 01 Feb 2001 14:56:47 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <20010201174946.B11607@redhat.com> you wrote:
> > Hi,
> 
> > On Thu, Feb 01, 2001 at 05:34:49PM +0000, Alan Cox wrote:
> > In the disk IO case, you basically don't get that (the only thing
> > which comes close is raid5 parity blocks).  The data which the user
> > started with is the data sent out on the wire.  You do get some
> > interesting cases such as soft raid and LVM, or even in the scsi stack
> > if you run out of mailbox space, where you need to send only a
> > sub-chunk of the input buffer. 
> 
> Though your describption is right, I don't think the case is very common:
> Sometimes in LVM on a pv boundary and maybe sometimes in the scsi code.


And if you are writing to a striped volume via a filesystem which can do
it's own I/O clustering, e.g. I throw 500 pages at LVM in one go and LVM
is striped on 64K boundaries.

Steve


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
