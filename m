Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284945AbRLFCnK>; Wed, 5 Dec 2001 21:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284946AbRLFCnA>; Wed, 5 Dec 2001 21:43:00 -0500
Received: from zero.tech9.net ([209.61.188.187]:5 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284945AbRLFCmt>;
	Wed, 5 Dec 2001 21:42:49 -0500
Subject: Re: [RFC][PATCH] cpus_allowed/launch_policy patch, 2.4.16
From: Robert Love <rml@tech9.net>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C0ED52E.B15F0ED7@us.ibm.com>
In-Reply-To: <3C0ECBE0.F21464FA@us.ibm.com>
	<Pine.LNX.4.40.0112051800400.1644-100000@blue1.dev.mcafeelabs.com> 
	<3C0ED52E.B15F0ED7@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 21:42:37 -0500
Message-Id: <1007606568.814.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-05 at 21:17, Matthew Dobson wrote:

> but, as soon as one of them exec()'s their no longer going to be using your
> functions.

But cpus_allowed is inherited, so why does it matter?

The only benefit I see to having it part of the fork operation as
opposed to Ingo's or my own patch, is that the parent need not be given
the same affinity.

And honestly I don't see that as a need.  You could always change it
back after the exec.  If that is unacceptable (you point out the cost of
forcing a task on and off a certain CPU), you could just have a wrapper
you exec that changes its affinity and then it execs the children.

	Robert Love

