Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbUKQS1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUKQS1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUKQSXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:23:10 -0500
Received: from uslec-66-255-166-25.cust.uslec.net ([66.255.166.25]:47488 "EHLO
	mail.ultrawaves.com") by vger.kernel.org with ESMTP id S262399AbUKQSVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:21:21 -0500
Subject: Re: [PATCH] cx88: fix printk arg. type
From: Jelle Foks <jelle@foks.8m.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
In-Reply-To: <20041117172519.GB8176@bytesex>
References: <419A89A3.90903@osdl.org>  <20041117172519.GB8176@bytesex>
Content-Type: text/plain
Message-Id: <1100715680.2004.33.camel@zoot.ultrawaves>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Nov 2004 13:21:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 12:25, Gerd Knorr wrote:
> > -		dprintk(0, "ERROR: Firmware size mismatch (have %ld, expected %d)\n",
> > +		dprintk(0, "ERROR: Firmware size mismatch (have %Zd, expected %d)\n",
> 
> Thanks, merged to cvs.  I like that 'Z'.  Or is that just a linux-kernel
> printk specific thingy?  Or is this standardized somewhere?  So I could
> use that in userspace code as well maybe?

btw Gerd, did you see the patch I sent to the video4linux mailing list
last sunday? It includes some small fixes to make things much closer to
working (some +1/-1 type fixes). After that patch, the main open issue
is syncing the video scaling and audio muting settings between the two
video devices/chips (2388 and 23416) -> The cx23416 needs to be set to
the same (/related) video scaling settings as the 2388, and the 2388
audio must be unmuted for the mpeg stream to contain audio.

And of course then it needs some ioctl for the mpeg codec settings.

Jelle.

> 
>   Gerd


