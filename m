Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRKSTWr>; Mon, 19 Nov 2001 14:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280641AbRKSTWh>; Mon, 19 Nov 2001 14:22:37 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:45578 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S280638AbRKSTWa>; Mon, 19 Nov 2001 14:22:30 -0500
Date: Mon, 19 Nov 2001 14:22:30 -0500
Message-Id: <200111191922.fAJJMUN30954@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
X-Newsgroups: linux.kernel
In-Reply-To: <Pine.GSO.4.33.0111081612240.17287-100000@sweetums.bluetronic.net>
In-Reply-To: <964381385.1005245622@[195.224.237.69]>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.33.0111081612240.17287-100000@sweetums.bluetronic.net>
	jfbeam@bluetopia.net wrote:

| People should not shit a brick at the suggestion of doing _some_ things
| as binary structures.  The parts of /proc that really are intended for humans
| (ie. driver "debug" information... /proc/slabinfo, /proc/drivers/rd/..., etc.)
| don't make sense in binary.  However, there are loads of things that DO make
| sense in binary format -- too many things reference them for further processing
| requiring conversion from/to text multiple times.  The number of people
| who do:
|  % grep -l foo /proc/[0-9]*/cmdline
| instead of:
|  % ps auxwww | grep foo
| are very VERY low.

  There's a great savings, to convert what is initially a text string to
some "binary" format.

  The advantage of text format is that humans can read it, and if it
changes they can almost always figure out what it means. Not everyone is
a C/PERL hacker who is happy writing machine independent binary
structures, while virtually every language ever written can and will
parse those text strings, and when it won't you can see why not.

  Having spent a lot of time developing tools to use the contents of
/proc, I have to feel that the savings in time of not reinventing every
existing wheel is so far in excess of any possible saving that
justifying the change on effeciency grounds is at best unconvincing.

  There are so many new and useful things which could be done that I
can't imaging this make-work change to something currently in place to
be a useful investment of time.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
