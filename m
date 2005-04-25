Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVDYENH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVDYENH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 00:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVDYENH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 00:13:07 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:13957 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262528AbVDYENB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 00:13:01 -0400
Message-ID: <426C6E24.5050203@ammasso.com>
Date: Sun, 24 Apr 2005 23:12:20 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, hch@infradead.org, roland@topspin.com,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <20050424205309.GA5386@kroah.com> <426C151F.3000407@ammasso.com> <20050425010351.GA21246@kroah.com>
In-Reply-To: <20050425010351.GA21246@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> I know of at least 1 x86-32 box from a three-letter-named company with
> this feature that has been shipping for a few _years_ now.  That box is
> pretty much everywhere now, and I know that other versions of it are
> also quite popular (despite the high cost...)

Hmm... Well, I think we were already planning on telling our customers that we don't 
support hot-swap RAM.  Is there a CONFIG option for that feature?

> Your hardware is just a pci card, right?  Why wouldn't it work on ppc64
> and ia64 then?

It's PCI-X, actually, and I don't think we've ever actually plugged it into a PPC box. 
Isn't Open Firmware support required for all PPC boxes, anyway?  Our PCI card is not OF 
compatible, AFAIK.

As for IA64, well, we could support it, but it's not a high enough priority.  We do have 
some CPU-specific code in our driver that we would need to port to IA-64.

> Wait, what _is_ "your stuff"?  The open-ib code?

No, if anything, it's the competition to IB.  It's called iWARP (RDMA over TCP/IP), and 
it's similar to IB except it uses gigabit ethernet instead of whatever hardware IB uses. 
Because we also support RMDA, we have the same problems as OpenIB, however, we would 
prefer that the kernel support OpenRDMA instead, since it's more generic.

 >  Or some other, private
> fork?  Any pointers to this stuff?

http://ammasso.com/support.html

The current version of the code calls sys_mlock() directly from the driver.  We haven't 
released yet the version that calls mlock().
