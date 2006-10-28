Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752082AbWJ1KIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWJ1KIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWJ1KIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:08:52 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53166 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752074AbWJ1KIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:08:51 -0400
Date: Sat, 28 Oct 2006 14:08:15 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take21 2/4] kevent: poll/select() notifications.
Message-ID: <20061028100815.GB15038@2ka.mipt.ru>
References: <11619654012104@2ka.mipt.ru> <45432B1A.8020503@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45432B1A.8020503@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 28 Oct 2006 14:08:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 12:04:10PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> Evgeniy Polyakov a écrit :
> 
> >+	file = fget(k->event.id.raw[0]);
> >+	if (!file)
> >+		return -ENODEV;
> 
> Please, do us a favor, and use EBADF instead of ENODEV.
> 
> EBADF : /* Bad file number */
> 
> ENODEV : /* No such device */
> 
> You have many ENODEV uses in your patches and that really hurts.

Ok :)

> Eric

-- 
	Evgeniy Polyakov
