Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSIZQS4>; Thu, 26 Sep 2002 12:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSIZQSz>; Thu, 26 Sep 2002 12:18:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58638 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261337AbSIZQSz>;
	Thu, 26 Sep 2002 12:18:55 -0400
Message-ID: <3D93348D.3060304@pobox.com>
Date: Thu, 26 Sep 2002 12:23:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] {read,write}s{b,w,l} or iobarrier_*()
References: <20020926155941.3602@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> So we have 2 solutions here (one of which I prefer, but I
> still want the debate open here):
> 
>  - Have all archs provide {read,write}s{b,w,l} functions.
> Those will hide all of the details of bytewapping & barriers
> from the drivers and can be used as-is for things like IDE
> MMIO iops.

I prefer this solution...


>  - Have all archs provide iobarrier_* functions. Here, drivers
> would still have to re-implement the transfer loops with
> raw_{read,write}{b,w,l} and do proper use of iobarrier_*.

I have a tulip patch from Peter de Shivjer (sp?) that adds 
iobarrier_rw() and I think it looks ugly as sin.  I would much prefer 
the first solution...

	Jeff



