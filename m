Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262834AbTCVQUu>; Sat, 22 Mar 2003 11:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262897AbTCVQUt>; Sat, 22 Mar 2003 11:20:49 -0500
Received: from holomorphy.com ([66.224.33.161]:52115 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262834AbTCVQUs>;
	Sat, 22 Mar 2003 11:20:48 -0500
Date: Sat, 22 Mar 2003 08:31:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lmbench results for 2.4 and 2.5
Message-ID: <20030322163129.GC30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
References: <3E7C8B22.7020505@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7C8B22.7020505@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 11:11:14AM -0500, Chris Friesen wrote:
> My previous testing with unix sockets prompted me to do a few lmbench runs 
> with 2.4.19 and 2.5.65.  The results have me a bit concerned, as there is 
> no area where 2.5 is faster and several where it is significantly slower.
> In particular:
> stat is 8 times worse
> open/close are 7 times worse
> fork is twice as expensive
> tcp latency is 5 times worse
> file deletion and mmap are both twice as expensive
> tcp bandwidth is 5 times worse
> Optimizing for muliple processors and heavy loads is nice, but this looks 
> like its happening at the cost of basic performance.  Is this really the 
> route we should be taking?

These aren't terribly informative without profiles (esp. cache perfctrs).

TCP to localhost was explained to me as some excess checksumming that
will eventually get removed before 2.6.0.

It's unclear why open()/close()/stat()/unlink() should be any different.

fork() is just rmap stuff. Try 2.5.65-mm2 and 2.5.65-mm3.


-- wli
