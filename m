Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTLQWHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTLQWHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:07:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47885 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264608AbTLQWHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:07:12 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: raid0 slower than devices it is assembled of?
Date: 17 Dec 2003 21:55:40 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brqjcs$7rb$1@gatekeeper.tmr.com>
References: <1071657159.2155.76.camel@abyss.local> <Pine.LNX.4.58.0312170758220.8541@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1071698140 8043 192.168.12.62 (17 Dec 2003 21:55:40 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312170758220.8541@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:
| 
| 
| On Wed, 17 Dec 2003, Peter Zaitsev wrote:
| > 
| > I'm pretty curious about this argument,
| > 
| > Practically as RAID5 uses XOR for checksum computation you do not have
| > to read the whole stripe to recompute the checksum.
| 
| Ahh, good point. Ignore my argument - large stripes should work well. Mea 
| culpa, I forgot how simple the parity thing is, and that it is "local".
| 
| However, since seeking will be limited by the checksum drive anyway (for 
| writing), the advantages of large stripes in trying to keep the disks 
| independent aren't as one-sided. 

There is no "the" parity drive, remember the RAID-5 parity is
distributed. A write takes two seeks, a read, a data write, and a parity
write, but the parity isn't a bottleneck, and as noted above the size
only need be the blocks containing the modified data.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
