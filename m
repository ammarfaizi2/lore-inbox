Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280890AbRKTEIi>; Mon, 19 Nov 2001 23:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280891AbRKTEIS>; Mon, 19 Nov 2001 23:08:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4712 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280890AbRKTEII>; Mon, 19 Nov 2001 23:08:08 -0500
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: replacing the page replacement algo.
In-Reply-To: <Pine.LNX.4.33L.0111190037550.4079-100000@imladris.surriel.com>
	<1006138361.605.12.camel@zaphod>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 20:49:06 -0700
In-Reply-To: <1006138361.605.12.camel@zaphod>
Message-ID: <m14rnq6r0t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter <spotter@cs.columbia.edu> writes:

> ok, but if what I'm interested in playing with right now is playing
> around with which pages get swapped out, and not with the actual
> reclamation procedure, is it ok to just play with swap_out and having it
> do the thing it does, and let the rest of the kernel behave as is, or
> will this cause problems?

The name of swap_out is historical.  It currently does no writing to
disk it just removes the page from the page tables.  But the page is
still in RAM.  The other routines are what decide which page should
actually be reused, or which pages get written.

The current code is both simple, auto-tuning and does a fairly good
job so look very closely at it before trying to randomly tune it. 

Eric
