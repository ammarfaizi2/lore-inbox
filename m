Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVAZBIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVAZBIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVAZBGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:06:21 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:57808 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262221AbVAZBEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:04:25 -0500
Date: Tue, 25 Jan 2005 17:04:04 -0800
From: Chris Wedgwood <cw@f00f.org>
To: George Anzinger <george@mvista.com>
Cc: Christoph Lameter <clameter@sgi.com>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] posix-timers: CPU clock support for POSIX timers
Message-ID: <20050126010404.GA21597@taniwha.stupidest.org>
References: <200501232325.j0NNPUg7006501@magilla.sf.frob.com> <41F5AF72.8000502@mvista.com> <Pine.LNX.4.58.0501241834190.19044@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501251450080.26368@schroedinger.engr.sgi.com> <41F6D8A0.5090404@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6D8A0.5090404@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:39:12PM -0800, George Anzinger wrote:

> I would like to get a read on the following defines...
> #define mmclock mmtimer.clock
> #define mmnode  mmtimer.node
> #define mmincr  mmtimer.incr
> #define mmexpires mmtimer.expires

Ick, we already abuse the preprocessor too much, I really don't like
that.  Yes, it saves a few keystrokes but makes things hard to find
and/or more vague when using cscope/grep, etc.
