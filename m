Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbSJCPqw>; Thu, 3 Oct 2002 11:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJCPqv>; Thu, 3 Oct 2002 11:46:51 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:9182
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id <S261314AbSJCPqt>; Thu, 3 Oct 2002 11:46:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: David Mosberger-Tang <David.Mosberger@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] backtrace
In-Reply-To: <7453.1033637889@ocs3.intra.ocs.com.au>
References: <3D9C004A.3080006@corvil.com> <7453.1033637889@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <20021003154651Z261325-8741+1357@vger.kernel.org>
Date: Thu, 3 Oct 2002 11:46:51 -0400

>>>>> On Thu, 03 Oct 2002 11:50:03 +0200, Keith Owens <kaos@sgi.com> said:

  Keith> Most architectures compile with -fomit-frame-pointer (except
  Keith> for ARM where RMK does it differently).  Neither gdb not
  Keith> glibc can cope with kernel code built with
  Keith> -fomit-frame-pointer.  See the horrible heuristics kdb has to
  Keith> apply to get any sort of backtrace on i386.

Keith knows this, but just to be clear: there is no problem unwinding
across functions compiled with -fomit-frame-pointer on ia64.  (Other
platforms could do the same if they took advantage of DWARF2 unwind
info.)

	--david
