Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317647AbSGOV2N>; Mon, 15 Jul 2002 17:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317649AbSGOV2M>; Mon, 15 Jul 2002 17:28:12 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:48628 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S317647AbSGOV2M>;
	Mon, 15 Jul 2002 17:28:12 -0400
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <20020712162306$aa7d@traf.lcs.mit.edu>
	<s5gsn2lt3ro.fsf@egghead.curl.com>
	<20020715173337$acad@traf.lcs.mit.edu>
	<s5gsn2kst2j.fsf@egghead.curl.com> <1026767676.4751.499.camel@tiny>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 17:31:07 -0400
In-Reply-To: <1026767676.4751.499.camel@tiny>
Message-ID: <s5gy9ccr84k.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> Yes, most mtas do this for queue files, I'm not sure how many do it for
> the actual spool file.

Maybe the control files are small enough to fit in one disk block,
making the operations atomic in practice.  Or something.

> mail server authors are more than welcome to recommend the best
> safety/performance combo for their product, and to ask the FS guys
> which combinations are safe.

Yeah, but it's a shame if those combinations require performance hits
like "synchronous directory updates" or, worse, "fsync() == sync()".

I really wish MTA authors would just support Linux's "fsync the
directory" approach.  It is simple, reliable, and fast.  Yes, it does
require Linux-specific support in the application, but that's what
application authors should expect when there is a gap in the
standards.

 - Pat
