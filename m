Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTFKWVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTFKWVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:21:12 -0400
Received: from mail.webmaster.com ([216.152.64.131]:22448 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264516AbTFKWVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:21:02 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Artemio" <artemio@artemio.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: SMP question
Date: Wed, 11 Jun 2003 15:34:44 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEKNDJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200306112313.30903.artemio@artemio.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello!

> > > How much performance will I loose this way? Is SMP *THAT* critical?
> >
> > 	You will lose about half your CPU power.

> Hmmm... So, you mean uni-processor Linux kernel can't see two
> processors as
> one "big" processor?

	Don't we wish. No, two processors is two processors.

> > > Also, if I turn hyperthreading off, how will it influence the
> > > system with SMP
> > > support? Without SMP support?

> > 	In a system with more than one physical CPU, hyperthreading
> > is not that
> > big of a performance boost.

> Okay, I will try turning hyperthreding off and see if RTLinux
> keeps hanging
> the machine.

	It sounds like you're experiencing a bug. You can do this kind of testing
to help determine the 'envelope' of the bug (that is, under what
circumstances it appears and under what circumstances it doesn't appear),
however this is not a substitute for fixing the bug. ;)

	Even if you find a configuration that doesn't show the bug, you still
should work with the RTLinux guys to track down the bug and get it fixed.
If, for example, it's due to unreliable hardware, turning off hyperthreading
might hide it but it will still be lurking there.

	RTLinux might be hanging because of problems with the code you're running.
Thinks like deadlock and priority inversion can become much more obvious in
an SMP machine, but can definitely still happen in a UP machine, just much
less often.

	DS


