Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbTIDTI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbTIDTI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:08:59 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1031
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265507AbTIDTI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:08:57 -0400
Date: Thu, 4 Sep 2003 12:08:56 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Diego Calleja Garc?a <diegocg@teleline.es>
Cc: Nick Piggin <piggin@cyberone.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
Message-ID: <20030904190856.GD13676@matchmail.com>
Mail-Followup-To: Diego Calleja Garc?a <diegocg@teleline.es>,
	Nick Piggin <piggin@cyberone.com.au>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030902231812.03fae13f.akpm@osdl.org> <20030904010852.095e7545.diegocg@teleline.es> <3F569641.9090905@cyberone.com.au> <20030904202319.7f9947c9.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904202319.7f9947c9.diegocg@teleline.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 08:23:19PM +0200, Diego Calleja Garc?a wrote:
> El Thu, 04 Sep 2003 11:32:49 +1000 Nick Piggin <piggin@cyberone.com.au> escribi?:
> 
> > Hmm... what's heavy gcc load?
> 
> make -j25 with 256 MB RAM.
> 
> My X server is reniced at -1; but reniced X to -10 and it didn't helped;
> -j15 was better (less swapping) but still I saw various mp3 & mouse skips.

And this worked good with Con's scheduler?

Try both schedulers on the same base (test4), and see if you see similair
differences.

I doubt it's the scheduler that's causing this problem.  Once you get into
swap like that, the scheduler shouldn't affect it too much...
