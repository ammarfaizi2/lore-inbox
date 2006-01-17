Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWAQLh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWAQLh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWAQLh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:37:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:60099 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750855AbWAQLh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:37:28 -0500
Date: Tue, 17 Jan 2006 12:37:27 +0100
From: Nick Piggin <npiggin@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unmount oops in log_do_checkpoint
Message-ID: <20060117113727.GB24083@wotan.suse.de>
References: <20060116160420.GA21064@wotan.suse.de> <20060116212250.GD12159@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116212250.GD12159@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 10:22:50PM +0100, Jan Kara wrote:
> > 2.6.15-git12 (and 11, not sure when it started) oops when unmounting
> > an ext3 filesystem. Looks like 'transaction' in log_do_checkpoint is
> > garbage.
> > 

[oops]

>   It would be useful to find out which patch cause it (by git bisect)
> but one obvious suspect is my merged ext3 patch to checkpoint.c. I'll
> investigate tomorrow.
> 

Yep, reverting jbd split checkpoint lists in -git12 fixes it. It is
100% reproducible so far, and every time rebooting with a patched
kernel fails to result in the oops.

Nick

