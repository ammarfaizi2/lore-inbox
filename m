Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbRBHLdb>; Thu, 8 Feb 2001 06:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRBHLdV>; Thu, 8 Feb 2001 06:33:21 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129649AbRBHLdI>;
	Thu, 8 Feb 2001 06:33:08 -0500
Message-ID: <20010208004938.E189@bug.ucw.cz>
Date: Thu, 8 Feb 2001 00:49:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andreas Dilger <adilger@turbolinux.com>,
        Jeffrey Keller <jeff@commerceflow.com>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Reasons to honor readonly mount requests
In-Reply-To: <3A7B7F8C.67C2B603@commerceflow.com> <200102030359.f133xrM02216@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200102030359.f133xrM02216@webber.adilger.net>; from Andreas Dilger on Fri, Feb 02, 2001 at 08:59:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I understand that both ext3fs and
> > reiserfs will try to fix corrupt filesystems (or at least filesystems
> > with unprocessed log entries) in-place even if they're mounted
> > read-only.  Clearly, virtual replay means more work, but -- just for
> > fun -- here are some cases in which it might matter:
> > 
> > 1. You want the disk image untouched for forensic analysis or data
> >    recovery.
> > 2. You don't trust the disk to do writes properly.
> > 3. You don't trust the driver to do writes properly.
> > 4. You want to test a newer or unstable FS implementation w/ option to
> >    go back to the older one.
> 
> Excluding the root fs (which probably isn't involved in these sorts of
> things anyways), you can always turn off the "RECOVERY" flag on the
> filesystem and mount ext3 as ext2, which will not do any recovery.

_If_ you happen to realize that mount -o ro -t ext3 is not really read
only. sct know it may write to filesystem, now I know it; but I
believe that if you asked Joe Admin 

"Linux writes to partition mounted read-only in some cases; is it a
bug?"

he would say

"YES!"
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
