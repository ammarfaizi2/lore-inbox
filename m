Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTJUUFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTJUUFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:05:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5636 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263285AbTJUUFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:05:33 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 19:55:32 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn42vk$ies$1@gatekeeper.tmr.com>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com>
X-Trace: gatekeeper.tmr.com 1066766132 18908 192.168.12.62 (21 Oct 2003 19:55:32 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F8E8101.70009@pobox.com>, Jeff Garzik  <jgarzik@pobox.com> wrote:
| Eli Billauer wrote:

| > Besides, it's quite easy to do something wrong with random numbers. By 
| > having a good source of random data, I suppose we can spare a lot of 
| > people the headache of getting their own user-space application right 
| > for the one-off thing they want to do.
| 
| This is completely bogus logic.  I can use this (incorrect) argument to 
| similar push for applications doing bsearch(3) or qsort(3) via a system 
| call.

Your argument is correct, but this is data generation rather than
analysis. In doing simulation it's desirable to ensure that multiple
instances of a program don't use the same numbers.

For instance, simulating user load against a server; I want the
simulation of human thinking time to be a number in the range n..m and
not to be the same for all threads. Sure I can get around that, and do,
but I wouldn't mind having a simple source of random bytes which was
quality PRNG and unique.

Again, this is not a case that this is a "must have" feature, just an
opinion that there are benefits to having such a feature which don't
apply to the cases you cited above.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
