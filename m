Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285184AbRLMU6E>; Thu, 13 Dec 2001 15:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285185AbRLMU5y>; Thu, 13 Dec 2001 15:57:54 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:19472 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S285184AbRLMU5q>; Thu, 13 Dec 2001 15:57:46 -0500
Message-Id: <200112132057.fBDKvhg10748@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: that stupid aic7xxx AHC_NSEGS bug 
In-Reply-To: Your message of "Thu, 13 Dec 2001 12:42:05 PST."
             <20011213.124205.38323630.davem@redhat.com> 
Date: Thu, 13 Dec 2001 13:57:43 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>We simply forget to initialize scb->sg_count in the non use_sg
>case, so if the previous usage of that scb has sg_count==AHC_NSEGS
>then we'd hit that panic erroneously.  Here is the fix below.

Which just goes to show you have useful Steve Lord's report was.
Even someone unfamiliar with the driver could figure this out once
someone bothered to provide decend debuggin info.

>"It can't possibly be my driver, something broke in some Linux
>subsystem which is making my driver break", sheesh get over it
>Justin...

That's a bit unfair David, and its also not an acurate quote.  I
did say to Nick Pasich, "I guarantee you though, it is not the aic7xxx
driver's fault" on 11/26, but ever since it became apparent that
I was wrong (11/29 perhaps?), I've been working with Nick to try
and reproduce the problem.  We all make mistakes David, even you.
Get over it. 8-)

--
Justin
