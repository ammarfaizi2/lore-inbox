Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVBUFj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVBUFj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 00:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVBUFj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 00:39:26 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:7671 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261866AbVBUFjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 00:39:22 -0500
To: Dustin Sallings <dustin@spy.net>
Cc: Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com,
       Tupshin Harper <tupshin@tupshin.com>, darcs-users@darcs.net,
       linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com>
	<200502172105.25677.pmcfarland@downeast.net>
	<421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random>
	<bc647aafb53842b58dd0279161fb48e0@spy.net>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 21 Feb 2005 14:39:05 +0900
In-Reply-To: <bc647aafb53842b58dd0279161fb48e0@spy.net> (Dustin Sallings's
 message of "Fri, 18 Feb 2005 09:50:52 -0800")
Message-ID: <buosm3q5v5y.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dustin Sallings <dustin@spy.net> writes:
> but the nicest thing about arch is that a given commit is immutable.
> There are no tools to modify it.  This is also why the crypto
> signature stuff was so easy to fit in.
>
> RCS and SCCS storage throws away most of those features.

Yeah, the basic way arch organizes its repository seems _far_ more sane
than the crazy way CVS (or BK) does, for a variety of reasons[*].  No
doubt there are certain usage patterns which stress it, but I think it
makes a lot more sense to use a layer of caching to take care of those,
rather than screwing up the underlying organization.

[*] (a) Immutability of repository files (_massively_ good idea)
    (b) Deals with tree-changes "naturally" (CVS-style ,v files are a
        complete mess for anything except file-content changes)
    (c) Directly corresponds to traditional diff 'n' patch, easy to
        think about, no surprises

-Miles
-- 
Saa, shall we dance?  (from a dance-class advertisement)
