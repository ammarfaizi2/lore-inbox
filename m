Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319033AbSHSVi1>; Mon, 19 Aug 2002 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319034AbSHSVi1>; Mon, 19 Aug 2002 17:38:27 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:44381 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S319033AbSHSVi0>; Mon, 19 Aug 2002 17:38:26 -0400
Date: Mon, 19 Aug 2002 16:42:22 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <100750000.1029793342@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0208191427220.1484-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208191427220.1484-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, August 19, 2002 02:29:08 PM -0700 Linus Torvalds
<torvalds@transmeta.com> wrote:

> No, you only need to make debugged children slightly pecial in wait4(), in
> that the parent must never see their state, only the fact that they are
> there (as if they were still running, in short, regardless of their _real_
> state)

So does that mean we need something like a 'count of children stolen by
debuggers' in the task struct that wait4() can check?

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

