Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270726AbTHJV6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270730AbTHJV6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:58:36 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:30223 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270726AbTHJV6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:58:35 -0400
Date: Sun, 10 Aug 2003 23:58:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jan Niehusmann <jan@gondor.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030810235834.A16865@pclin040.win.tue.nl>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl> <20030810205513.GA6337@gondor.com> <20030810231955.A16852@pclin040.win.tue.nl> <20030810213450.GA7050@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810213450.GA7050@gondor.com>; from jan@gondor.com on Sun, Aug 10, 2003 at 11:34:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 11:34:50PM +0200, Jan Niehusmann wrote:
> On Sun, Aug 10, 2003 at 11:19:55PM +0200, Andries Brouwer wrote:

> Sorry - I mentioned it in an earlier post with a different subject. It's
> plain 2.4.21. 
> 
> > It it is zero, then you are hit by something avoided by the patch
> > I sketched yesterday evening or so.
> 
> It is 0, yes. May it be caused by the following lines in pdc202xx_old.c?
> 
>         if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
>                 hwif->addressing = (hwif->channel) ? 0 : 1;

OK. So, this means that you cannot access past the 2^28 sector boundary.

So, you can address at most 137 GB of your disk.

Did you say that it was 250 GB?


