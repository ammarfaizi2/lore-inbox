Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbRCJRAh>; Sat, 10 Mar 2001 12:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131052AbRCJRA1>; Sat, 10 Mar 2001 12:00:27 -0500
Received: from ns.suse.de ([213.95.15.193]:61714 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131051AbRCJRAR>;
	Sat, 10 Mar 2001 12:00:17 -0500
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_sched_yield fast path
In-Reply-To: <XFMail.20010310123041.davidel@xmailserver.org>
From: Andi Kleen <ak@suse.de>
Date: 10 Mar 2001 17:59:33 +0100
In-Reply-To: Davide Libenzi's message of "10 Mar 2001 11:23:39 +0100"
Message-ID: <oup4rx1tv9m.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:


> Probably the rate at which is called sys_sched_yield() is not so high to let
> the performance improvement to be measurable.

LinuxThreads mutexes call sched_yield() when a lock is locked, so when you 
have a  multithreaded program with some lock contention it'll be called a lot.

-Andi
