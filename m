Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVLMC5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVLMC5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 21:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVLMC5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 21:57:50 -0500
Received: from rtr.ca ([64.26.128.89]:45536 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750955AbVLMC5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 21:57:49 -0500
Message-ID: <439E38A4.30204@rtr.ca>
Date: Mon, 12 Dec 2005 21:57:40 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > (5) Redirects the following to apply to the new mutexes rather than the
 >     traditional semaphores:
 >
 >	down()
 >	down_trylock()
 >	down_interruptible()
 >	up()

This will BREAK a lot of out-of-tree stuff if merged.

So please figure out some way to hang a HUGE banner out there
so that the external codebases know they need updating.

The simplest way would be to NOT re-use the up()/down() symbols,
but rather to either keep them as-is (counting semaphores),
or delete them entirely (so that external code *knows* of the change).

Cheers
