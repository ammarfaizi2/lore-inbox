Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWIKQi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWIKQi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWIKQi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:38:28 -0400
Received: from maggie.spheresystems.co.uk ([82.71.70.17]:59823 "EHLO
	maggie.spheresystems.co.uk") by vger.kernel.org with ESMTP
	id S965034AbWIKQi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:38:27 -0400
From: Andrew Bird <ajb@spheresystems.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Spinlock debugging
Date: Mon, 11 Sep 2006 17:38:21 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200609111632.27484.ajb@spheresystems.co.uk> <1157992570.23085.169.camel@localhost.localdomain>
In-Reply-To: <1157992570.23085.169.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111738.21818.ajb@spheresystems.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan
	Yes, I have low_latency set for kernels lower than 2.6.17. I'm currently 
testing using 2.6.15. When you mention 'write method for flow control' do you 
mean for software XON/XOFF etc?
	On a more generic note, is the spinlock debug output read as a stack and what 
do the '=======' line breaks signify, looping?

Thanks


Andrew

On Monday 11 September 2006 17:36, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 16:32 +0100, ysgrifennodd Andrew Bird (Sphere
>
> Systems):
> > will be lost. But if I comment out the line that tells the tty layer that
> > it's implemented, I end up with a BUG - spinlock recursion. Can anybody
> > tell me how to interpret the output?
>
> Looks like your driver calls flush_to_ldisc with low latency set and
> then can't handle the flush_to_ldisc causing n_tty to call back into the
> write method for flow control.
>
> Alan
