Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbREQHYl>; Thu, 17 May 2001 03:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261265AbREQHYb>; Thu, 17 May 2001 03:24:31 -0400
Received: from zeus.kernel.org ([209.10.41.242]:64683 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261294AbREQHYV>;
	Thu, 17 May 2001 03:24:21 -0400
Date: Tue, 15 May 2001 16:17:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010515161750.B38@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com> <Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, May 14, 2001 at 09:43:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm really serious about doing "resume from disk". If you want a fast
> boot, I will bet you a dollar that you cannot do it faster than by loading
> a contiguous image of several megabytes contiguously into memory. There is
> NO overhead, you're pretty much guaranteed platter speeds, and there are
> no issues about trying to order accesses etc. There are also no issues
> about messing up any run-time data structures.

resume from disk is actually pretty hard to do in way it is readed linearily.

While playing with swsusp patches (== suspend to disk) I found out that
it was slow. It needs to do atomic snapshot, and only reasonable way to
do that is free half of RAM, cli() and copy.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

