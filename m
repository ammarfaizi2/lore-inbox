Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423017AbWAMWUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423017AbWAMWUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbWAMWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:20:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:38807 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423017AbWAMWUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:20:43 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: drepper@gmail.com, robustmutexes@lists.osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, daviado@gmail.com
Subject: Re: Robust futex patch for Linux 2.6.15
References: <b324b5ad0601131316m721f959eu37b741f9e5557a2e@mail.gmail.com>
	<20060113132704.207336d7.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 13 Jan 2006 23:20:43 +0100
In-Reply-To: <20060113132704.207336d7.akpm@osdl.org>
Message-ID: <p73lkxj22is.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> +static int futex_deadlock(struct rt_mutex *lock)
> +{
> +	DEFINE_WAIT(wait);
> +
> +	_raw_spin_unlock(&lock->wait_lock);
> +	_raw_spin_unlock(&current->pi_lock);

And why is there a pi_lock if the code isn't supposed to support PI?

-Andi
