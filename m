Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTFIRxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTFIRxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:53:02 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:44195 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S261188AbTFIRxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:53:00 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-mm6
Date: Mon, 9 Jun 2003 19:06:34 +0100
User-Agent: KMail/1.5.9
References: <20030607151440.6982d8c6.akpm@digeo.com> <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
In-Reply-To: <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306091906.34155.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 June 2003 18:45, Maciej Soltysiak wrote:
> > . -mm kernels will be running at HZ=100 for a while.  This is because
> >   the anticipatory scheduler's behaviour may be altered by the lower
> >   resolution.  Some architectures continue to use 100Hz and we need the
> >   testing coverage which x86 provides.
>
> The interactivity seems to have dropped. Again, with common desktop
> applications: xmms playing with ALSA, when choosing navigating through
> evolution options or browsing with opera, music skipps.
> X is running with nice -10, but with mm5 it ran smoothly.

[alistair] 07:02 PM [~] uname -r
2.5.70-mm6

For what it's worth, I'm running an LFS base system with very few packages 
installed over the top. X is as packaged, it is not reniced. I am, however, 
running setiathome constantly in the background, which seems to pound the 
scheduler.

As Maciej reported, this seems to be significantly better with -mm5 (HZ = 
1000?). Amusingly, doing a renice -20 `pidof xmms` seems to make absolutely 
no difference to the scheduler in 2.5-mm.

This kernel does not have preempt enabled.

Cheers,
Alistair.
