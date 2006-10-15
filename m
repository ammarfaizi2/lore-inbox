Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWJOXYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWJOXYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWJOXYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 19:24:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932144AbWJOXYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 19:24:22 -0400
Message-ID: <4532C2C5.6080908@redhat.com>
Date: Sun, 15 Oct 2006 16:22:45 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Eric Dumazet <dada1@cosmosbay.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
References: <11587449471424@2ka.mipt.ru> <200610051245.03880.dada1@cosmosbay.com> <20061005105536.GA4838@2ka.mipt.ru> <200610051409.31826.dada1@cosmosbay.com> <20061005123715.GA7475@2ka.mipt.ru>
In-Reply-To: <20061005123715.GA7475@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Existing design does not allow overflow.

And I've pointed out a number of times that this is not practical at 
best.  There are event sources which can create events which cannot be 
coalesced into one single event as it would be required with your design.

Signals are one example, specifically realtime signals.  If we do not 
want the design to be limited from the start this approach has to be 
thought over.


>> So zap mmap() support completely, since it is not usable at all. We wont 
>> discuss on it.
> 
> Initial implementation did not have it.
> But I was requested to do it, and it is ready now.
> No one likes it, but no one provides an alternative implementation.
> We are stuck.

We need the mapped ring buffer.  The current design (before it was 
removed) was broken but this does not mean it shouldn't be implemented. 
  We just need more time to figure out how to implement it correctly.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
