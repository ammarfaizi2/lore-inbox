Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSCVHlB>; Fri, 22 Mar 2002 02:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292813AbSCVHkw>; Fri, 22 Mar 2002 02:40:52 -0500
Received: from c17877.carlnfd1.nsw.optusnet.com.au ([210.49.140.231]:498 "EHLO
	cskk.homeip.net") by vger.kernel.org with ESMTP id <S292730AbSCVHka>;
	Fri, 22 Mar 2002 02:40:30 -0500
Date: Fri, 22 Mar 2002 18:40:37 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: debugging eth driver
Message-ID: <20020322074036.GA28009@amadeus.home>
Reply-To: cs@zip.com.au
In-Reply-To: <3C93945A.8040305@lnxw.com> <25257.1016329003@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:36 17 Mar 2002, Keith Owens <kaos@ocs.com.au> wrote:
| 			printf "%-25s%s\n", $head[$i], $f[$i];

Just a remark on a piece of code I see done a lot,
when formatting things for printf in columns, do this:

	print "%-25s %s\n", ...
	  note! ----^

This _guarentees_ a space between one field ond the next. Ps and ls are
examples of commands whose output is regularly mangled in this way by
wide column values. Enforcing a single space between fields in the format
string avoids this. If the extra width bugs you, notch the %-25s down one.

There's plenty of formatting out there subject to this problem; let's
not help it with examples.

Cheers,
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Disclaimer: Opinions expressed here are CORRECT, mine, and not PSLs or NMSUs..
	- Larry Cunningham <larry@psl.nmsu.edu>
