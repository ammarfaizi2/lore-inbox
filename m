Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTLMA2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTLMA2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:28:22 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:60166 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S262315AbTLMA2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:28:21 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide 
In-reply-to: Your message of "Fri, 12 Dec 2003 18:25:56 -0000."
             <20031212182556.GB10584@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Dec 2003 11:28:11 +1100
Message-ID: <9653.1071275291@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003 18:25:56 +0000, 
Dave Jones <davej@redhat.com> wrote:
>On Sat, Dec 13, 2003 at 03:25:52AM +1100, Keith Owens wrote:
> > Also calls to smp_call_function() need to be wrapped in preempt_disable,
> > plus any work that is done on the current cpu before/after calling a
> > function on the other cpus.  Lack of preempt disable could result in
> > the operation being done twice on one cpu and not at all on another.
>
>And where you want to do the same thing on every processor, there's a
>handy on_each_cpu() which takes care of this for you.

I know, but there is code in 2.6 that calls smp_call_function directly,
without preempt disable around it.

