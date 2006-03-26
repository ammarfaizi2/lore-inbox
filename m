Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWCZXt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWCZXt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCZXt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:49:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38058 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932222AbWCZXt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:49:56 -0500
Date: Mon, 27 Mar 2006 01:47:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060326234722.GA25331@elte.hu>
References: <Pine.LNX.4.44L0.0603270025020.2708-100000@lifa01.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603270025020.2708-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Hi,
>  I got the patch I mentioned earlier to run. It passes my userspace
> testscripts as well as all the scripts for Thomas's rtmutex-tester on a UP
> machine.
> 
> The idea is to avoid the deadlocks by releasing all locks before going 
> to the next lock in the chain. I use get_/put_task_struct to avoid the 
> task disappearing during the iteration.

but we lose reliable deadlock detection ...

how do you guarantee that some other CPU doesnt send us on some 
goose-chase?

	Ingo
