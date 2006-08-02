Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWHBCUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWHBCUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWHBCUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:20:08 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:669
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751033AbWHBCUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:20:07 -0400
Date: Tue, 1 Aug 2006 19:19:56 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rt8 crash amd64
Message-ID: <20060802021956.GC26364@gnuppy.monkey.org>
References: <20060802011809.GA26313@gnuppy.monkey.org> <1154482302.30391.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154482302.30391.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:31:42PM -0400, Steven Rostedt wrote:
> On Tue, 2006-08-01 at 18:18 -0700, Bill Huey wrote:
> > [   42.124525]        <ffffffff8029ae98>{atomic_dec_and_spin_lock+21}
> > [   42.131032]        <ffffffff8025fd89>{schedule+236}
> > [   42.136195]        <ffffffff8026078f>{rt_lock_slowlock+351}
> > [   42.142086]        <ffffffff8026117d>{__lock_text_start+13}
> > [   42.147966]        <ffffffff8029ae98>{atomic_dec_and_spin_lock+21}
> > [   42.154476]        <ffffffff8020c4e9>{dput+57}
> > [   42.159194]        <ffffffff802093f3>{__link_path_walk+1710}
> > [   42.165166]        <ffffffff802617ad>{_raw_spin_unlock+46}
> > [   42.170961]        <ffffffff8020db81>{link_path_walk+103}
> > [   42.176672]        <ffffffff8020be5a>{do_path_lookup+644}
> > [   42.182379]        <ffffffff80223829>{__user_walk_fd+63}
> > [   42.187994]        <ffffffff8023fce4>{vfs_lstat_fd+33}
> > [   42.193434]        <ffffffff8022b3e4>{sys_newlstat+34}
> > [   42.198871]        <ffffffff8025ce3d>{error_exit+0}
> > [   42.204040]        <ffffffff8025bf22>{system_call+126}
> 
> This back trace is definitely ugly.  Do you get this all the time? And
> if so, could you compile in frame pointers and try again.  (I'll dig
> through this in the mean time.) 

Not sure, I'm getting hard reboots as well from what looks like more
atomic scheduling violations. I'll tweek my kernel config to be more
friendly about these things. It looked like it was in the rtmutex code,
which is why I CCed you.

Any other configuration suggestions ?

bill

