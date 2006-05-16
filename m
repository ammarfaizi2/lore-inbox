Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWEPLwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWEPLwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEPLwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:52:16 -0400
Received: from mout2.freenet.de ([194.97.50.155]:10944 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750781AbWEPLwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:52:15 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] Twofish cipher i586-asm optimized
Date: Tue, 16 May 2006 13:52:12 +0200
User-Agent: KMail/1.8.3
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org
References: <200605071156.57844.jfritschi@freenet.de> <200605072247.46655.jfritschi@freenet.de> <20060516074424.GA17773@gondor.apana.org.au>
In-Reply-To: <20060516074424.GA17773@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161352.12308.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 09:44, Herbert Xu wrote:
> On Sun, May 07, 2006 at 08:47:46PM +0000, Joachim Fritschi wrote:
> > After going over my patch again, i realized i missed the .cra_priority
> > and .cra_driver_name setting in the crypto api struct. Here is an updated
> > version of my patch:
> >
> > http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-i586-asm-2.6.1
> >7-2.diff
>
> Thanks for doing this Joachim.  I like the result.
>
> But the duplicate key code is a bit too much.  The fact that AES does
> it should only serve as a reminder for us to fix it, not to create even
> more duplication.
>
> So could you please move the key generation code into a separate file,
> say crypto/twofish-common.c which can then be shared by all twofish
> implementations?
Sure, i will resubmit the patches in a few days.
>
> BTW, please include the actual patches the next time you submit them
> along with Signed-off-by lines.  You should consult the file
> Documentation/SubmittingPatches for detailed instructions.
Seems like i referred to the wrong documentation then. I read the faq on 
kernel.org ( http://www.kernel.org/pub/linux/docs/lkml/#s4-1 ) and tried to 
follow the instructions :/. Sorry about that.

Regards,
Joachim
