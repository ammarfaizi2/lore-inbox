Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUCSXRR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUCSXRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:17:16 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:39697 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S263177AbUCSXRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:17:11 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <tigran@veritas.com>
Cc: "Justin Piszcz" <jpiszcz@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux Kernel Microcode Question
Date: Fri, 19 Mar 2004 15:16:33 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEGHLDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 19 Mar 2004 14:55:07 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, 18 Mar 2004, David Schwartz wrote:
> > 	It is at least theoeretically possible that a microcode
> > update might cause
> > an operation that's normally done very quickly (in dedicated
> > hardware) to be
> > done by a slower path (microcode operations) to fix a bug in
> > the dedicated
> > hardware

> Did you dream that up or did you read it somewhere? If the latter, where?

	Since you agree with me, I'm not sure I understand why it matters.

> All operations are done by "dedicated hardware" and microcode DOES modify
> that hardware, or rather the way instructions are "digested". So, applying
> microcode doesn't make anything slower per se, it's just replacing one
> code sequence with another code sequence. If a new code happens to be
> slower than the old one then of course the result will be slower, but the
> reverse is also true. When you fix a bug in a particular software why
> should a bugfix be apriori slower than the original code? Think about it.

	I didn't say it would have to be slower. I said it might force an operation
to be done by a slower path. You seem to agree with me that the new code
could happen to be slower than the old one.

	As for why a bugfix would be likely to be slower than the original code,
it's because of the limitations of the microcode update. The microcode
update can't change wiring, so if the problem is in wiring, then the
microcode would have to bypass that wiring. One would presume the wiring was
there for a reason -- to accelerate something.

> So please do not spread misinformation that applying microcode makes
> something slower. If anything, it should make things faster, as long as
> the guys at Intel are writing the correct (micro)code.

	I'm simply saying that it's at least theoretically possible that a
microcode update might increase correctness at the expense of performance.
The only contrary position would be that such a thing is impossible. The
position I'm refuting is that there is not, even in theory, any downside to
performing a microcode update.

	By the way, there is reason to believe that microcode updates can redirect
into microcode operations normally performed in hardware (though I know for
sure only that certain exceptions can be handled this way on at least one
Intel processor); however, I think it would be rather foolish to prefer
speed over correctness. I have also heard of microcode updates that
supposedly fixed performance problems.

	DS


