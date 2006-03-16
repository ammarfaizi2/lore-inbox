Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWCPVRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWCPVRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWCPVRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:17:44 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:30182 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751450AbWCPVRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:17:44 -0500
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: blaisorblade@yahoo.it, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <mtk-manpages@gmx.net>
In-Reply-To: <20060316200201.GA20315@nevyn.them.org>
References: <200603150415_MC3-1-BAB1-D3CE@compuserve.com>
	 <20060316200201.GA20315@nevyn.them.org>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 16:16:38 -0500
Message-Id: <1142543798.3284.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 15:02 -0500, Daniel Jacobowitz wrote:
> >        PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP
> >               For  PTRACE_SYSEMU,  continue  and  stop  on  entry  to the next
> >               syscall, which will not  be  executed.   For  PTRACE_SYSEMU_SIN-
> >               GLESTEP, so the same but also singlestep if not a syscall.
> 
> I think this is right; I had nothing to do with these :-)
I didn't have anything to do with it, but this description is correct
(if a bit confusing).  I think that you should explicitly say (assuming
that Paolo does not have any objections):

PTRACE_SYSEMU only makes sense at a call's exit, not at entry.
PTRACE_SYSEMU is only practical if you want to emulate all of a
process's system calls (as is done in UML), because you can not examine
the process's registers before making the decision to emulate a call.

Charles

