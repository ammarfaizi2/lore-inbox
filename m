Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWJNKQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWJNKQG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 06:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWJNKQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 06:16:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13710 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752128AbWJNKQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 06:16:03 -0400
Date: Sat, 14 Oct 2006 05:15:07 -0500
From: Robin Holt <holt@sgi.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Robin Holt <holt@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_user_pages(..., write==1, ...) may return with readable pte.
Message-ID: <20061014101507.GA6316@lnx-holt.americas.sgi.com>
References: <20061013203342.GA21610@lnx-holt.americas.sgi.com> <20061014045305.GA23740@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014045305.GA23740@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dup_mmap holds mmap_sem for write. get_user_pages caller must hold it
> for read.

I could have sworn I checked for that and found a down_read(), but
now that I look when I have some time, it is clearly a down_write().
Sorry for the distraction.

It is a user job that is passing data between hosts.  The host is
under heavy memory pressure and one rank of the MPI job gets silent
data corruption.

Thanks and sorry for wasting your time,
Robin
