Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSE1S4l>; Tue, 28 May 2002 14:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSE1S4l>; Tue, 28 May 2002 14:56:41 -0400
Received: from holomorphy.com ([66.224.33.161]:17385 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316878AbSE1S4k>;
	Tue, 28 May 2002 14:56:40 -0400
Date: Tue, 28 May 2002 11:56:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@transmeta.com
Subject: Re: O(1) count_active_tasks()
Message-ID: <20020528185620.GS14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, torvalds@transmeta.com
In-Reply-To: <20020526035115.GM14918@holomorphy.com> <1022451477.20316.24.camel@sinai> <20020526230319.GN14918@holomorphy.com> <1022599985.20316.32.camel@sinai> <1022609318.20317.65.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 11:08:35AM -0700, Robert Love wrote:
> Well, I did some tests.  I changed count_active_tasks to calculate using
> both methods and whine if they did not match.  I then put the machine
> under extreme load with a lot of I/O.  Finally, I ran `uptime(1)' in a
> tight loop and watched the console.
> Over a long period of constant count_active_tasks calls via `uptime(1)',
> I had only a couple messages.  This is most likely <=1% of the calls and
> in each case we were one to high with the new method (140 vs 141, for
> example).
> Not sure why, or if it is even us or nr_running() or even the old method
> that is off ... but who cares.  It is a statistic.


Thanks a million for doing some independent testing! I should have
been more clear about the fact that it was an approximate method, and
that it varies from mainline occasionally and slightly. But this is the
nature of the patch I proposed.


Thanks,
Bill
