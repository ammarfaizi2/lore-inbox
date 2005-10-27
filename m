Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVJ0Hvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVJ0Hvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVJ0Hvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:51:55 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:38638 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S964984AbVJ0Hvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:51:54 -0400
Date: Thu, 27 Oct 2005 16:48:04 +0900 (JST)
Message-Id: <20051027.164804.63130901.noboru.obata.ar@hitachi.com>
To: tytso@mit.edu, hugh@veritas.com
Cc: lkml@oxley.org, pavel@ucw.cz, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <20051019190013.GD10969@thunk.org>
References: <20051019190013.GD10969@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2005, "Theodore Ts'o" wrote:
> 
> On Tue, Oct 18, 2005 at 03:10:24PM +0100, Hugh Dickins wrote:
> > On Tue, 18 Oct 2005, OBATA Noboru wrote:
> > > 
> > > I have a bitter experience in analyzing a partial dump.  The
> > > dump completely lacks the PTE pages of user processes and I had
> > > to give up analysis then.  A partial dump has a risk of failure
> > > in analysis.
> > 
> > Page tables of user processes are very often essential in a dump.
> > Data pages of user processes are almost always just a waste of
> > space and time in a dump.  Please don't judge against partial
> > dumps on the basis of one that was badly selected.

My apologies.  What should be blamed was the bad partial dump
implementation and not the partial dump itself.

But I don't think data pages of user processes are almost always
useless, as Ted comments.

> We've had hard-to-reproduce problems out in the field where being able
> to find the data pages of the user process was critical to figuring
> out what the heck was going on.  So I wouldn't be quite so eager to
> dismiss the need for user pages.  There are times when they come in
> quite handy....

I agree.

When a system crashed, a user may want to _avoid_ the cause of
crash and continue operation, until bugs are fixed and well
tested.

Then we try to find the way to avoid the specific situation that
has caused the crash.  Sometimes it can be done by changing
resource limits, timeouts, or some fancy features in XXX.conf of
user programs.

To investigate the behavior of user processes, having data pages
of user processes in a dump is mandatory.

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

