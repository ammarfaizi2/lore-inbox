Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTKQVJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKQVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:09:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65285 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261777AbTKQVJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:09:16 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test9-mm3
Date: 17 Nov 2003 20:58:31 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bpbcpn$fh1$1@gatekeeper.tmr.com>
References: <200311141110.12671.pbadari@us.ibm.com> <100480000.1068841761@flay>
X-Trace: gatekeeper.tmr.com 1069102711 15905 192.168.12.62 (17 Nov 2003 20:58:31 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <100480000.1068841761@flay>,
Martin J. Bligh <mbligh@aracnet.com> wrote:
| >> > - Several ext2 and ext3 allocator fixes.  These need serious testing on
| >> > big SMP.
| >> 
| >> OK, ext3 survived a swatting on the 16-way as well. It's still slow as
| >> snot, but it does work ;-) No changes from before, methinks.
| >> 
| >> Diffprofile for kernbench (-j) from ext2 to ext3 on mm3
| >> 
| >>      27022    16.3% total
| >>      24069    53.3% default_idle
| >>        583     2.4% page_remove_rmap
| >>        539   248.4% fd_install
| >>        478   388.6% __blk_queue_bounce
| > 
| > What driver are you using ? Why are you bouncing ?
| 
| qlogicisp. Because the driver is crap? ;-)

The question is, does that make your testing better or worse in terms of
checking the new code? Clearly you have done a good job of checking the
"disk can't keep up" case, is there a need to test further with a much
higher transaction rate?

I would assume that if there were lock issues they would have shown up,
which is probably all that's needed.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
