Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTJXRrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJXRrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:47:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3596 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262427AbTJXRru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:47:50 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 24 Oct 2003 17:37:44 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnbo18$49b$1@gatekeeper.tmr.com>
References: <3F8E552B.3010507@users.sf.net> <20031022025602.GH17713@pegasys.ws> <20031022122251.A3921@borg.org> <3F97498D.9050704@storm.ca>
X-Trace: gatekeeper.tmr.com 1067017064 4395 192.168.12.62 (24 Oct 2003 17:37:44 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F97498D.9050704@storm.ca>, Sandy Harris  <sandy@storm.ca> wrote:

| Do you think you need this before there's a file system? Why?
| Or are you thinking of boxes that don't have a file system?
| Or not writable? Not local?
| 
| > --and even speed),
| 
| I suspect that's the real issue. People report using other
| things because /dev/urandom is too slow.
| 
| Can we speed up /dev/urandom? Or perhaps write a PRNG daemon?

I know someone noted that frandom couldn't just replace urandom, but I
don't recall why. The values appear to be at least a good, the speed is
much higher, and since it's already in use, there would be no opposition
to having it, since we need to have something.

Could someone clarify why this isn't a drop-in replacement?

| If all we need is a library, there's an RC4-based one named
| prng.c in the FreeS/WAN libraries.
| http://www.freeswan.org/freeswan_snaps/CURRENT-SNAP/doc/manpage.d/ipsec_prng.3.html
| 
| Two threads discussing the desin start at:
| http://lists.freeswan.org/pipermail/design/2002-March/002166.html
| http://lists.freeswan.org/pipermail/design/2002-March/002207.html
| 
| > but the Kent who doesn't
| > want the kernel to be exploded into a catalogue of competing random
| > number generators.
| 
| I'm with you there.

No argument, but the performance of urandom is quite poor in terms of
speed and having every application generate their own number using
their own possibly badly flawed algorithm certainly qualifies as
undesirable.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
