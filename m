Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268582AbRGYQMJ>; Wed, 25 Jul 2001 12:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268586AbRGYQL7>; Wed, 25 Jul 2001 12:11:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61487 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268582AbRGYQLr>; Wed, 25 Jul 2001 12:11:47 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: landley@webofficenow.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva>
	<01072415352102.00631@localhost.localdomain>
	<m1vgkhh0j5.fsf@frodo.biederman.org> <01072514530401.00907@starship>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jul 2001 10:05:47 -0600
In-Reply-To: <01072514530401.00907@starship>
Message-ID: <m1d76pgfj8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Daniel Phillips <phillips@bonn-fries.net> writes:

> On Wednesday 25 July 2001 10:32, Eric W. Biederman wrote:
> > Consider having a swapfile on tmpfs.
> 
> Ooh, a truly twisted thought.
> 
> We'd know we're making progress when we can prove it doesn't deadlock.

Given all of that I think I going to go try to hack up a version that
works.  

The ensuring we don't deadlock sounds like it will require some shared
mechanisms with journaling filesystems.  The whole pinned ram
problem.  So to some extent it looks like a 2.4 problem.  Though I'd
rather solve it in 2.5.x first.

Eric
