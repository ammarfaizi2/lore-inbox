Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934844AbWKXP17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934844AbWKXP17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 10:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934842AbWKXP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 10:27:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10952 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934840AbWKXP16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 10:27:58 -0500
Message-ID: <45670F3B.2000503@redhat.com>
Date: Fri, 24 Nov 2006 07:26:51 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru>	<456621AC.7000009@redhat.com>	<45662522.9090101@garzik.org>	<45663298.7000108@redhat.com>	<45664160.6060504@cosmosbay.com> <20061124001412.371ec4e7.akpm@osdl.org> <4566AE48.70409@cosmosbay.com>
In-Reply-To: <4566AE48.70409@cosmosbay.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Being able to direct a particular request on a particular CPU is 
> certainly something that cannot be hardcoded in 'the new kevent interface'.

Nobody is proposing this.  Although I have proposed that if the kernel 
knows which CPU can best service a request it might hint as much.

But in general, you're free to decentralize as much as you want.  But 
this does not mean it should not also be possible to use a number of 
threads in the same loop and the same kevent queue.  That's the part 
which needs designing, the separate queues will always be possible.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
