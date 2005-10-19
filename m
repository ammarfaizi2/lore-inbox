Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVJSTAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVJSTAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJSTAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:00:50 -0400
Received: from thunk.org ([69.25.196.29]:43231 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751226AbVJSTAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:00:49 -0400
Date: Wed, 19 Oct 2005 15:00:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hugh Dickins <hugh@veritas.com>
Cc: OBATA Noboru <noboru.obata.ar@hitachi.com>, lkml@oxley.org, pavel@ucw.cz,
       hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Message-ID: <20051019190013.GD10969@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hugh Dickins <hugh@veritas.com>,
	OBATA Noboru <noboru.obata.ar@hitachi.com>, lkml@oxley.org,
	pavel@ucw.cz, hyoshiok@miraclelinux.com,
	linux-kernel@vger.kernel.org
References: <200510121002.59098.lkml@oxley.org> <20051018.224722.126577332.noboru.obata.ar@hitachi.com> <Pine.LNX.4.61.0510181501380.8233@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510181501380.8233@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 03:10:24PM +0100, Hugh Dickins wrote:
> On Tue, 18 Oct 2005, OBATA Noboru wrote:
> > 
> > I have a bitter experience in analyzing a partial dump.  The
> > dump completely lacks the PTE pages of user processes and I had
> > to give up analysis then.  A partial dump has a risk of failure
> > in analysis.
> 
> Page tables of user processes are very often essential in a dump.
> Data pages of user processes are almost always just a waste of
> space and time in a dump.  Please don't judge against partial
> dumps on the basis of one that was badly selected.

We've had hard-to-reproduce problems out in the field where being able
to find the data pages of the user process was critical to figuring
out what the heck was going on.  So I wouldn't be quite so eager to
dismiss the need for user pages.  There are times when they come in
quite handy....

						- Ted
