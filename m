Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUF1U5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUF1U5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUF1U5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:57:05 -0400
Received: from mail1.kontent.de ([81.88.34.36]:21684 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265084AbUF1U4D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:56:03 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: drivers/block/ub.c
Date: Mon, 28 Jun 2004 22:57:11 +0200
User-Agent: KMail/1.6.2
Cc: Scott Wood <scott@timesys.com>, zaitcev@redhat.com, greg@kroah.com,
       arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com>
In-Reply-To: <20040628132531.036281b0.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406282257.11026.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 28. Juni 2004 22:25 schrieb David S. Miller:
> That's true.  But if one were to propose such a feature to the gcc
> guys, I know the first question they would ask.  "If no padding of
> the structure is needed, why are you specifying this new
> __nopadding__ attribute?"

It would replace some uses of __packed__, where the first element
is aligned.

> I think it's bad to just "smack this attribute onto any structure that
> _MIGHT_ need it on some platform"  I never do that in my drivers,
> and they work on all platforms.  For example, if you have a simple
> DMA descriptor structure such as:
> 
>         struct txd {
>                 u32 dma_addr;
>                 u32 length;
>         };
> 
> It is just total and utter madness to put a packed or the proposed
> __nopadding__ attribute on that structure.  Yet this seems to be
> what was suggested now and at the beginning of this thread.

I did suggest that. I still think it has some advantages, but I am not
sure whether they are sufficient
1) Not every structure is that simple
2) It is an architecture specific requirement
3) padding rules might change
4) It simplifies driver writing

	Regards
		Oliver
