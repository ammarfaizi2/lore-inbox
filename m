Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTBLDMc>; Tue, 11 Feb 2003 22:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbTBLDMc>; Tue, 11 Feb 2003 22:12:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45579 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266772AbTBLDMb>; Tue, 11 Feb 2003 22:12:31 -0500
Date: Tue, 11 Feb 2003 19:18:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <200302120313.h1C3DX419736@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302111912580.2667-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Roland McGrath wrote:
> 
> POSIX clearly specifies that stopping and continuing "shall not affect the
> behavior of any function" (when SIGCONT is SIG_DFL or SIG_IGN, or is blocked).

You just have to read it in a way that says "partial results are
permissible, and are part of the normal behaviour". And then the fact that
when ^Z happens you get partial results from pipes is not "different
behaviour" from a qualitative standpoint - even though in fact we'd get a
full result if the ^Z didn't happen.

Put another way: ^Z does perturb the exact details of a read from a pipe, 
but it does not in any way change the _semantics_ of the read.

			Linus

