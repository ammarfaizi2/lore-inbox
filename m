Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTLPWq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTLPWq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:46:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33547 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263945AbTLPWqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:46:24 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
Date: 16 Dec 2003 22:34:54 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bro1ae$1v5$1@gatekeeper.tmr.com>
References: <3FDDD923.30509@pobox.com> <Pine.LNX.4.58.0312151019160.1488@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1071614094 2021 192.168.12.62 (16 Dec 2003 22:34:54 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312151019160.1488@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:
| 
| 
| On Mon, 15 Dec 2003, Jeff Garzik wrote:
| >
| > Pardon me for asking a dumb and possibly impertinent question, but why
| > keep it around at all?
| 
| Hey, I've tried to kill it off, but people keep on wanting it. Either
| because they are lazy and can't upgrade the tools to write CD's with the
| regular ide-cd interfaces, or because they have IDE tapes and want to use
| st.c to drive them.

And MO drives. There was something funky with LS-120 and ZIP drives that
ide-scsi did right and ide-floppy didn't, but I haven't tried it since
about 2.5.4x, and at that time ide-scsi worked, other than logging some
status messages.

There is some MS backup software which wants SCSI tapes to run. I don't
know if that's under wine or vmware, it's on my list of things to check
and report, but down the list. One more reason for ide-scsi, though.
| 
| ide-cd.c obviously does _not_ handle tapes. We could make the generic IDE
| layer open them and let people do SCSI commands on them (and that probably
| wouldn't be too hard), but somebody needs to _care_.

I think there are a fair number of people who care, they just don't
happen to have the combination of skills, hardware, and time to go play.
Don't take it out, let people grouse and eventually fixes will come,
if only from vendors.
| 
| Right now ide-scsi (and the alternatives, like doing SCSI commands onto
| any ATAPI device just using the regular IDE layer) are mostly hampered by
| people complaining about them but not actually _doing_ anything.

1 - testing and reporting problems IS doing something.
2 - you supplied a patch which did fix some of the problems.
3 - I got another tape drive so I could test on non-production hardware
    and it died, haven't tried the replacement because we have had
    blizzards two bleeping weekends in a row. And this weekend is
    Christmas prep weekend, so don't expect nice test results this year.
4 - We now have three rescued kittens in the house, they are LOTS more
    fun to play with than ide-scsi ;-)
| 
| I'll try something that rips out the reset handling altogether from
| ide-scsi, let's see how that works (should be easy enough to test with a
| black marker and an old CD-ROM).

And hopefully the person who reported MO problems will test, because I
believe that was one of his major problems.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
