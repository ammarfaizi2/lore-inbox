Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132625AbRDXQht>; Tue, 24 Apr 2001 12:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDXQhj>; Tue, 24 Apr 2001 12:37:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:760 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132338AbRDXQh3>; Tue, 24 Apr 2001 12:37:29 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rw_semaphores, optimisations try #3 
In-Reply-To: Your message of "Tue, 24 Apr 2001 08:40:58 PDT."
             <Pine.LNX.4.21.0104240838040.15642-100000@penguin.transmeta.com> 
Date: Tue, 24 Apr 2001 17:37:13 +0100
Message-ID: <7062.988130233@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
> - nobody will look up the list because we do have the spinlock at this
>   point, so a destroyed list doesn't actually _matter_ to anybody

I suppose that it'll be okay, provided I take care not to access a block for a
task I've just woken up.

> - list_remove_between() doesn't care about the integrity of the entries
>   it destroys. It only uses, and only changes, the entries that are still
>   on the list.

True. Okay, I can change it to use that.

David
