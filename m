Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbTJUW2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTJUW2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:28:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45572 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263469AbTJUW2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:28:10 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 22:18:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn4bav$ji4$1@gatekeeper.tmr.com>
References: <3F8E552B.3010507@users.sf.net> <3F8E8101.70009@pobox.com> <bn42vk$ies$1@gatekeeper.tmr.com> <20031021212136.GA15043@hh.idb.hist.no>
X-Trace: gatekeeper.tmr.com 1066774687 20036 192.168.12.62 (21 Oct 2003 22:18:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031021212136.GA15043@hh.idb.hist.no>,
Helge Hafting  <helgehaf@aitel.hist.no> wrote:
| On Tue, Oct 21, 2003 at 07:55:32PM +0000, bill davidsen wrote:
| 
| > Your argument is correct, but this is data generation rather than
| > analysis. In doing simulation it's desirable to ensure that multiple
| > instances of a program don't use the same numbers.
| > 
| > For instance, simulating user load against a server; I want the
| > simulation of human thinking time to be a number in the range n..m and
| > not to be the same for all threads. Sure I can get around that, and do,
| > but I wouldn't mind having a simple source of random bytes which was
| > quality PRNG and unique.
| 
| Each thread use the same userspace pseudo-random generator (faster
| than any kernel implementation as you avoid the syscalls) and
| each initialize by a single read from urandom, so they get
| different series of numbers.

As noted, I do get around that... some care needs to be taken calling
random number generators from threads, since some have internal storage
in addition to the seed which can be provided by the caller.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
