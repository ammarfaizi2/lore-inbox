Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270734AbTHJVT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270739AbTHJVT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:19:59 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:46599 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S270734AbTHJVT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:19:57 -0400
Date: Sun, 10 Aug 2003 23:19:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jan Niehusmann <jan@gondor.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030810231955.A16852@pclin040.win.tue.nl>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl> <20030810205513.GA6337@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810205513.GA6337@gondor.com>; from jan@gondor.com on Sun, Aug 10, 2003 at 10:55:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 10:55:13PM +0200, Jan Niehusmann wrote:
> On Thu, Aug 07, 2003 at 11:12:36PM +0200, Andries Brouwer wrote:
> > Last September or so there was a long discussion about a
> > filesystem that was destroyed. But what I recall is that
> > in the end it turned out not to be a hardware problem,
> > but a precedence problem - two missing parentheses in the driver.
> > 
> > Google will tell you all, I suppose. Search for Promise and Isely.
> 
> Yes, thanks, I found these mails, and they may describe exactly the 
> symptoms I saw on my server. So perhaps the fixes have not been
> (correctly) applied?
> 
> I only saw the mails from Mike Isely, but no 'official' response. Do you
> remember if the patches got accepted by one of the maintainers? Andre?

I see no kernel version in your post, that would be the first thing
of interest. Next, look at this addressing variable via /proc.
It it is zero, then you are hit by something avoided by the patch
I sketched yesterday evening or so. Otherwise we must look further.

It looks like all your corrupted places are at a multiple of 2^27.

Also, I see that you do e2fsck on a mounted filesystem. Terrible.

Andries


