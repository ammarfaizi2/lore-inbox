Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135895AbREFWII>; Sun, 6 May 2001 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135892AbREFWH5>; Sun, 6 May 2001 18:07:57 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:9896 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S135896AbREFWHu>;
	Sun, 6 May 2001 18:07:50 -0400
Date: Mon, 7 May 2001 00:07:49 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: page_launder() bug
In-Reply-To: <l03130303b71b795cab9b@[192.168.239.105]>
Message-ID: <Pine.A41.4.31.0105070003210.59664-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, 6 May 2001, Jonathan Morton wrote:

> >-			 page_count(page) == (1 + !!page->buffers));
>
> Two inversions in a row?  I'd like to see that made more explicit,
> otherwise it looks like a bug to me.  Of course, if it IS a bug...
it's not a bug.
if page->buffers is zero, than the page_count(page) is 1, and if
page->buffers is other than zero, page_count(page) is 2.
so it checks if page is really used by something.
maybe this last line is not true, but the !!page->buffers is not a bug.

Bye,
Szabi


