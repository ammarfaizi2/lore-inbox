Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318987AbSHTO2a>; Tue, 20 Aug 2002 10:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318939AbSHTO2a>; Tue, 20 Aug 2002 10:28:30 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:57888 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318987AbSHTO23>; Tue, 20 Aug 2002 10:28:29 -0400
Date: Tue, 20 Aug 2002 09:32:22 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <26840000.1029853942@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208200035250.5286-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208200035250.5286-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, August 20, 2002 12:36:36 AM +0200 Ingo Molnar <mingo@elte.hu>
wrote:

> in fact we have this already, almost:
> 
> 	if (!list_empty(&current->ptrace_children))
> 
> then block (or return -EAGAIN). Instead of the current -ENOCHLD.

No fair adding new code in the middle of a discussion :)

Seriously, that looks like it solves the problem.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

