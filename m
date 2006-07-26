Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWGZPlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWGZPlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWGZPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:41:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:688 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751656AbWGZPlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:41:10 -0400
Message-ID: <44C78D0D.6040809@redhat.com>
Date: Wed, 26 Jul 2006 11:41:01 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@googlemail.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com>	 <6e0cfd1d0607260400r731489a1tfd9e6c5a197fb0bd@mail.gmail.com>	 <1153912268.2732.30.camel@taijtu> <6e0cfd1d0607260604w3e8636e4taaea4bc918397b34@mail.gmail.com>
In-Reply-To: <6e0cfd1d0607260604w3e8636e4taaea4bc918397b34@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On 7/26/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

>> I think Rik would want to set all the already unmapped pages to volatile
>> state in the hypervisor.

> I guessed that as well. It isn't good enough. Consider a guest with a
> large (virtual) memory size and a host with a small physical memory
> size. The guest will never put any page on the inactive_clean list
> because it does not have memory pressure. 

Well, the management software running on top of everything
should tweak the inactive_clean targets in the various guests
so the total amount of volatile memory is large enough...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
