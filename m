Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTEHN5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbTEHN5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:57:17 -0400
Received: from siaag2aa.compuserve.com ([149.174.40.131]:13215 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261489AbTEHN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:57:17 -0400
Date: Thu, 8 May 2003 10:08:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: top stack (l)users for 2.5.69
To: Jvrn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305081009_MC3-1-37FA-2407@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have no idea, what a 'typical processor' might look like. But the
> thing most CPU seem to have in common is that they save two registers
> either on the stack or into other registers that only exist for this
> purpose (SRR on PPC).
>
> Once that has happened, the OS has the job to figure out where it's
> stack (or equivalent) is located, *without* clobbering the registers.
> Once that is done, it can save all the registern on the stack,
> including SRR.

  On i386 the CPU automatically switches to the stack corresponding to
the privilege level (PL) of the interrupt handler, then pushes the
instruction pointer and flags onto that stack.  It is theoretically
possible to write unprivileged interrupt handlers by using conforming
code segments, in which case a stack switch will not occur, but such a
handler cannot touch anything but registers and stack so it's not very
useful.
