Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSHBP7U>; Fri, 2 Aug 2002 11:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSHBP7Q>; Fri, 2 Aug 2002 11:59:16 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:500 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316408AbSHBP5L>; Fri, 2 Aug 2002 11:57:11 -0400
Date: Fri, 2 Aug 2002 12:00:40 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers
Message-ID: <20020802120040.A25119@redhat.com>
References: <Pine.LNX.4.44.0208021118120.28515-100000@serv> <Pine.LNX.4.44.0208020833110.18265-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208020833110.18265-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 02, 2002 at 08:39:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 08:39:34AM -0700, Linus Torvalds wrote:
> We already do this right, and there is no reason to _break_ the fact that
> we do it right. Can you come up with a _single_ reason for why we should
> break existing standardized binary interfaces?

Personally, I think that uninterruptible file io is good, but there needs 
to be an upper limit to the maximum size of the io.  As it stands today, 
someone can do a single multigigabyte read or write that is completely 
uninterruptible (even to kill -9), but could take a minute or more to 
complete.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
