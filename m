Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTJUTeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTJUTeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:34:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31507 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263292AbTJUTeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:34:21 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 19:24:20 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn4154$i74$1@gatekeeper.tmr.com>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com>
X-Trace: gatekeeper.tmr.com 1066764260 18660 192.168.12.62 (21 Oct 2003 19:24:20 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F8E8101.70009@pobox.com>, Jeff Garzik  <jgarzik@pobox.com> wrote:

| In this case, there is no such requirement.  More below.

If the result is used for crypto that is a requirement, as noted in the
original post. See below. And if it's in a shared library it's subject
to various other attempts at control or duplication of results.
| 
| 
| > But it's really a matter of taste. That's why I bring up the subject here.
| 
| 
| Processors are trending towards putting RNG on the CPU.  VIA won't be 
| the last, I predict.  When generating random bits is a single 
| instruction, "xstore", userspace applications _should_ be directly using 
| this.  It should not be in-kernel.  And similarly, if there is no 
| requirement that the kernel's entropy pool is used, the userspace 
| application _should_ be where the implementation lives.

If you are running multiple threads you may really want some independent
random numbers. Looking at this, I believe that if I open the device and
then various threads read blocks from the device, each will get
independent random numbers.

Take this as "there are benefits to having this in the kernel" and not
"this really should be in the kernel." A contribution to the discussion.

What I don't hear is results from testing, from doing this as a
procedure, etc.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
