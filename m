Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVISNoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVISNoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 09:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVISNoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 09:44:04 -0400
Received: from [212.76.81.182] ([212.76.81.182]:1797 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932390AbVISNoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 09:44:02 -0400
From: Al Boldi <a1426z@gawab.com>
To: netdev@vger.kernel.org
Subject: Re: workaround large MTU and N-order allocation failures
Date: Mon, 19 Sep 2005 16:38:15 +0300
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20050918143526.GA24181@localdomain> <1127111462.5272.7.camel@npiggin-nld.site>
In-Reply-To: <1127111462.5272.7.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509191638.15506.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> On Sun, 2005-09-18 at 17:35 +0300, Dan Aloni wrote:
> > Hello,
> >
> > Is there currently a workaround available for handling large MTU
> > (larger than 1 page, even 2-order) in the Linux network stack?
> >
> > The problem with large MTU is external memory fragmentation in
> > the buddy system following high workload, causing alloc_skb() to
> > fail.
> >
> > I'm interested in patches for both 2.4 and 2.6 kernels.
>
> Yes there is currently a workaround. That is to keep increasing
> /proc/sys/vm/min_free_kbytes until your allocation failures stop.

How do you do it in 2.4?

--
Al
