Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270720AbTHJVex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270726AbTHJVex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:34:53 -0400
Received: from mail.gondor.com ([212.117.64.182]:22790 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S270720AbTHJVev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:34:51 -0400
Date: Sun, 10 Aug 2003 23:34:50 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030810213450.GA7050@gondor.com>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl> <20030810205513.GA6337@gondor.com> <20030810231955.A16852@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810231955.A16852@pclin040.win.tue.nl>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 11:19:55PM +0200, Andries Brouwer wrote:
> I see no kernel version in your post, that would be the first thing
> of interest. Next, look at this addressing variable via /proc.

Sorry - I mentioned it in an earlier post with a different subject. It's
plain 2.4.21. 

> It it is zero, then you are hit by something avoided by the patch
> I sketched yesterday evening or so. Otherwise we must look further.

It is 0, yes. May it be caused by the following lines in pdc202xx_old.c?

        if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
                hwif->addressing = (hwif->channel) ? 0 : 1;

> Also, I see that you do e2fsck on a mounted filesystem. Terrible.

:-)
I know. But it's mounted read only, and to be sure I tried it without
mounting the file system, as well. 
But the most important prove that it's not a fs problem is that writing
to one partition changed contents of a different partition.

Jan

