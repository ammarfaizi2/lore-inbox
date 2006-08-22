Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWHVMRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWHVMRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWHVMRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:17:49 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55982 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932201AbWHVMRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:17:48 -0400
Date: Tue, 22 Aug 2006 16:17:10 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [PATCH] kevent_user: remove non-chardev interface
Message-ID: <20060822121709.GA4815@2ka.mipt.ru>
References: <12345678912345.GA1898@2ka.mipt.ru> <11561555871530@2ka.mipt.ru> <20060822115459.GA10839@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060822115459.GA10839@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 22 Aug 2006 16:17:12 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 12:54:59PM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> Currently a user can create a user kevents in two ways:
> 
>  a) simply open() the kevent chardevice
>  b) use sys_kevent_ctl with the KEVENT_CTL_INIT cmd type
> 
> both are equally easy to use for the user, but to support type b) a lot
> of code in kernelspace is required.  remove type b to save lots of code
> without functionality loss.

I personally do not have objections against it, but it introduces
additional complexies - one needs to open /dev/kevent and then perform
syscalls on top of returuned file descriptor.

If there are no objections, I will apply this patch.

-- 
	Evgeniy Polyakov
