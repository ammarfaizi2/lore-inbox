Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311229AbSCTCE1>; Tue, 19 Mar 2002 21:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311238AbSCTCER>; Tue, 19 Mar 2002 21:04:17 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16581 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S311229AbSCTCEE>; Tue, 19 Mar 2002 21:04:04 -0500
Date: Tue, 19 Mar 2002 21:04:03 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Theodore Tso <tytso@mit.edu>, Peter Hartley <pdh@utter.chaos.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
Message-ID: <20020319210403.C27655@redhat.com>
In-Reply-To: <006701c1cf6d$d9701230$2701230a@electronic> <20020319191018.A23000@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 07:10:18PM -0500, Theodore Tso wrote:
> The other fix is that the filesize limit *really* shouldn't apply to
> block devices.  We should probably do both fixes.

The filesize limit did not apply to block devices until ~2.4.10, so 
this manifestation of the bug is a recent introduction.

The whole rlimit mess itself is a might bit awful since it and the 
nonstandard 2.2 file size extensions resulted in a horribly conflicting 
glob of problems.  *sigh*

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
