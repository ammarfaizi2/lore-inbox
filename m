Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTGGLpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbTGGLpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:45:00 -0400
Received: from [213.39.233.138] ([213.39.233.138]:40607 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264934AbTGGLo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:44:59 -0400
Date: Mon, 7 Jul 2003 13:58:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030707115853.GB7104@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de> <20030704175439.GE22152@wohnheim.fh-wedel.de> <16134.2877.577780.35071@cargo.ozlabs.ibm.com> <20030705073946.GD32363@wohnheim.fh-wedel.de> <16135.57910.936187.611245@cargo.ozlabs.ibm.com> <20030706101754.GA23341@wohnheim.fh-wedel.de> <16137.22943.460130.914035@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16137.22943.460130.914035@nanango.paulus.ozlabs.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 July 2003 21:29:35 +1000, Paul Mackerras wrote:
> 
> Well, the most reliable way to get a core dump when you trash the
> stack or something is to have no SIGSEGV handler at all. :)

True.  For the old ppc code, the problem occurs with any other signal
as well, but the signal stack problem is specific to SIGSEGV and
possibly SIGBUS, depending on architecture.

> In any case, there are all sorts of things that could go wrong and
> leave the process stuck in an infinite loop.  If you really want a
> core dump when things go wrong then you probably need some sort of
> watchdog process plus a way for one process to force another to dump
> core and exit (like a SIGKILL but with a core dump as well).

That would be optimal, yes.  This external core dump signal doesn't
exist yet, does it?

> You haven't convinced me that the kernel is doing anything wrong or
> even suboptimal - it seems to me that you have run into some
> unintended consequences of your code, that's all.  You can't expect
> the kernel to work around all the bugs in your user processes. :)

Correct.  The userspace will have bugs and it will have plenty.  The
interesting question is only, if we can gather enough debugging data
to identify and fix those bugs, when they occur.  This is embedded, no
user is going to narrow down the problem.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
