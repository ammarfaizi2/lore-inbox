Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRBAPKf>; Thu, 1 Feb 2001 10:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129864AbRBAPK1>; Thu, 1 Feb 2001 10:10:27 -0500
Received: from ns.caldera.de ([212.34.180.1]:48133 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130530AbRBAPKM>;
	Thu, 1 Feb 2001 10:10:12 -0500
Date: Thu, 1 Feb 2001 16:09:53 +0100
From: Christoph Hellwig <hch@caldera.de>
To: bsuparna@in.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201160953.A17058@caldera.de>
Mail-Followup-To: bsuparna@in.ibm.com,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com>; from bsuparna@in.ibm.com on Thu, Feb 01, 2001 at 08:14:58PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 08:14:58PM +0530, bsuparna@in.ibm.com wrote:
> 
> >Hi,
> >
> >On Thu, Feb 01, 2001 at 10:25:22AM +0530, bsuparna@in.ibm.com wrote:
> >>
> >> >We _do_ need the ability to stack completion events, but as far as the
> >> >kiobuf work goes, my current thoughts are to do that by stacking
> >> >lightweight "clone" kiobufs.
> >>
> >> Would that work with stackable filesystems ?
> >
> >Only if the filesystems were using VFS interfaces which used kiobufs.
> >Right now, the only filesystem using kiobufs is XFS, and it only
> >passes them down to the block device layer, not to other filesystems.
> 
> That would require the vfs interfaces themselves (address space
> readpage/writepage ops) to take kiobufs as arguments, instead of struct
> page *  . That's not the case right now, is it ?

No, and with the current kiobufs it would not make sense, because they
are to heavy-weight.  With page,length,offsett iobufs this makes sense
and is IMHO the way to go.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
