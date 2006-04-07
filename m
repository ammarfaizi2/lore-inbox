Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWDGGus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWDGGus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWDGGus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:50:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:23171 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932317AbWDGGur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:50:47 -0400
From: Neil Brown <neilb@suse.de>
To: "Joshua Hudson" <joshudson@gmail.com>
Date: Fri, 7 Apr 2006 16:50:35 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17462.3003.229525.874004@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait4/waitpid/waitid oddness
In-Reply-To: message from Joshua Hudson on Thursday April 6
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
	<bda6d13a0604061909u69dd8453me4c9b96cca8d34f5@mail.gmail.com>
	<217AB2B7-BD72-49BE-AB02-AA952728073B@mac.com>
	<bda6d13a0604062340p5f5ff496u20c7f6135284b43f@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday April 6, joshudson@gmail.com wrote:
> On 4/6/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > On Apr 6, 2006, at 22:09:48, Joshua Hudson wrote:
> > > I'm the guy who removed the check in link() about source is a
> > > directory, found out what broke, and am working on a patch to fix
> > > all the resulting breakage.  Your task is apt to be a lot simpler.
> >
> > I seem to recall the reason why hardlinking directories was
> > prohibited had something more to do with some unfixable races and
> > deadlocks in the kernel; not to mention creating self-referential
> > directory trees that are never freed and chew up disk space.
> 
> You recall correctly. I have fixed the self-referrential problem, and I
> am testing a fix for the races and deadlocks. Desk proof is not good
> enough for me.

I wonder what you are doing about the conceptual problem of 
  What does ".." mean now?

NeilBrown
