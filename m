Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbULWL3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbULWL3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 06:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbULWL3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 06:29:41 -0500
Received: from cantor.suse.de ([195.135.220.2]:30408 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261210AbULWL3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 06:29:40 -0500
Date: Thu, 23 Dec 2004 12:29:39 +0100
From: Andi Kleen <ak@suse.de>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3, i386: fpu handling on sigreturn
Message-ID: <20041223112939.GG14560@wotan.suse.de>
References: <41C9B21F.90802@fujitsu-siemens.com.suse.lists.linux.kernel> <p73mzw5zzk2.fsf@verdi.suse.de> <41CA0813.1070707@fujitsu-siemens.com> <20041222235448.GA17720@verdi.suse.de> <41CA90F4.8000800@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CA90F4.8000800@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I don't agree. AFAICS, if used_math isn't reset, on the next
> attempt of the process to use the fpu, it will be reloaded with the
> values, that come from the sighandler and that still reside in
> thread.i387. Thus, clear_cpu() without resetting used_math has no
> effect to the userspace task.
> Resetting current->used_math to 0 would make math_state_restore()
> calling init_fpu(), that clears thread.i387 before the fpu is loaded.

Ok I agree.  I revised the patch here.

-Andi

