Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRIDT0t>; Tue, 4 Sep 2001 15:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRIDT0j>; Tue, 4 Sep 2001 15:26:39 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:25604 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268133AbRIDT0g>; Tue, 4 Sep 2001 15:26:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Tue, 4 Sep 2001 21:33:48 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010904112629.A27988@cs.cmu.edu> <Pine.LNX.4.21.0109041220260.1578-100000@freak.distro.conectiva> <20010904131401.A30296@cs.cmu.edu>
In-Reply-To: <20010904131401.A30296@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010904192654Z16548-32385+671@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 4, 2001 07:14 pm, Jan Harkes wrote:
> To get back on the thread I jumped into, I totally agree with Linus that
> writeout should be as soon as possible. Probably even as soon as an
> inactive dirty page hits the inactive dirty list, which would
> effectively turn the inactive dirty list into your laundry list.

No, we don't want that, we need the inactive list as a test of short-term
inactivity.  It doesn't make sense to begin the writeout until the page
has made it to the other end of the inactive ist.  Otherwise you just
revert to "one-hand-clock".

--
Daniel
