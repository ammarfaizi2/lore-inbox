Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030610AbWFVGdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbWFVGdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWFVGdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:33:13 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:19349 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030610AbWFVGdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:33:12 -0400
Message-ID: <449A39A6.7060209@namesys.com>
Date: Wed, 21 Jun 2006 23:33:10 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, vs <vs@thebsh.namesys.com>
CC: Nick Orlov <bugfixer@list.ru>, linux-kernel@vger.kernel.org,
       Jeff Mahoney <jeffm@suse.com>, reiserfs-dev@namesys.com
Subject: Re: bitmap loading related reiserfs changes in 2.6.17-mm1 are broken
References: <20060622032733.GA5158@nickolas.homeunix.com> <20060621204303.47facd01.akpm@osdl.org>
In-Reply-To: <20060621204303.47facd01.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>It would really help if Chris or one of the namesys developers could take
>the time to review and test these patches closely, please.
>  
>
Chris's code also has QA problems.  Because I don't control their
salaries, they both just basically ignore the QA process that the rest
of Namesys uses, and have exactly the results one would expect.  I no
longer encourage non-Namesys companies to pay our developers directly 
--- because of this experience.

That QA process is: everyone must get their patch reviewed and tested by
a second developer before sending it in.  Elena is not qualified to
review the code, but she is able to run a standard suite of tests (one
of which is gcc....) in addition to whatever special test is required
for the patch.   I review the design aspects of the patches, but leave
to others to find most of the coding errors.

Everyone once in a while someone strays from it, and I complain
privately about it.  The percentage of time that it is a mistake to
stray from it is remarkably high.....

Unfortunately, there is both real user demand for the
on-demand-bitmap-loading, and a proper qa of it is non-trivial.  I
propose that vs look at it next week.  vs, please ack.  Chris, if you
are available, please take a look as well.

Jeff has done a lot of good work in optimizing V3 bitmap related code,
and I would like to thank him for that.  It did a lot for our
performance.  Chris's work on the journaling code was also very
important and I am very grateful for it.  A better QA methodology could
have dramatically reduced the number of bugs in that code though.

Hans


