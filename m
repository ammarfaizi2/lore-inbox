Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbULNFZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbULNFZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 00:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbULNFZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 00:25:59 -0500
Received: from brown.brainfood.com ([146.82.138.61]:53894 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261422AbULNFZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 00:25:54 -0500
Date: Mon, 13 Dec 2004 23:25:44 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Roland McGrath <roland@redhat.com>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] make ITIMER_REAL per-process
In-Reply-To: <200412140357.iBE3vg0k008058@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412132325130.2173@gradall.private.brainfood.com>
References: <200412140357.iBE3vg0k008058@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Roland McGrath wrote:

>
> POSIX requires that setitimer, getitimer, and alarm work on a per-process
> basis.  Currently, Linux implements these for individual threads.  This
> patch fixes these semantics for the ITIMER_REAL timer (which generates
> SIGALRM), making it shared by all threads in a process (thread group).

Hrm.  This could be useful for gprof.
