Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281562AbRKUNvM>; Wed, 21 Nov 2001 08:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281381AbRKUNvC>; Wed, 21 Nov 2001 08:51:02 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58732 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281050AbRKUNuz>; Wed, 21 Nov 2001 08:50:55 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <Pine.LNX.4.33L.0111211016270.4079-100000@imladris.surriel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Nov 2001 06:31:51 -0700
In-Reply-To: <Pine.LNX.4.33L.0111211016270.4079-100000@imladris.surriel.com>
Message-ID: <m1hero1c8o.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 20 Nov 2001, Eric W. Biederman wrote:
> > "David S. Miller" <davem@redhat.com> writes:
> >
> > > I do not agree with your analysis.
> >
> > Neither do I now but not for your reasons :)
> >
> > I looked again we are o.k. but just barely.  mmput explicitly checks
> > to see if it is freeing the swap_mm, and fixes if we are.  It is a
> > nasty interplay with the swap_mm global, but the code is correct.
> 
> To be honest I don't see the reason for this subtle
> playing with swap_mm in mmput(), since the refcounting
> should mean we're safe.

We only hold a ref count for the duration of swap_out_mm.
Not for the duration of the value in swap_mm.

Eric
