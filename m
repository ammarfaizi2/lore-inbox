Return-Path: <linux-kernel-owner+w=401wt.eu-S1761292AbWLINui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761292AbWLINui (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761264AbWLINui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:50:38 -0500
Received: from main.gmane.org ([80.91.229.2]:48830 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761292AbWLINuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:50:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: [patch 24/32] add bottom_half.h
Date: Sat, 09 Dec 2006 15:50:02 +0200
Message-ID: <457ABF0A.8020809@mandriva.org>
References: <20061208235751.890503000@sous-sol.org> <20061209000207.057219000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mingo@elte.hu, ak@suse.de
X-Gmane-NNTP-Posting-Host: ndn243.bob.fi
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <20061209000207.057219000@sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> With CONFIG_SMP=n:
> 
> drivers/input/ff-memless.c:384: warning: implicit declaration of function 'local_bh_disable'
> drivers/input/ff-memless.c:393: warning: implicit declaration of function 'local_bh_enable'
> 
> Really linux/spinlock.h should include linux/interrupt.h.  But interrupt.h
> includes sched.h which will need spinlock.h.
> 
> So the patch breaks the _bh declarations out into a separate header and
> includes it in bothj interrupt.h and spinlock.h.
> 
> Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
> Cc: Andi Kleen <ak@suse.de>
> Cc: <stable@kernel.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
> 
>  include/linux/bottom_half.h |    5 +++++

This file is missing in patch-2.6.19.1-rc[1,2].bz2

--
Thomas

