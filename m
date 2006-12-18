Return-Path: <linux-kernel-owner+w=401wt.eu-S1754264AbWLRQsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264AbWLRQsj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbWLRQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:48:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49848 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbWLRQsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:48:38 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: bugme-daemon@bugzilla.kernel.org, Zhang Yanmin <yanmin.zhang@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
References: <200612181543.kBIFhcIc001555@fire-2.osdl.org>
Date: Mon, 18 Dec 2006 09:48:01 -0700
In-Reply-To: <200612181543.kBIFhcIc001555@fire-2.osdl.org>
	(bugme-daemon@bugzilla.kernel.org's message of "Mon, 18 Dec 2006
	07:43:38 -0800")
Message-ID: <m1mz5lqhfi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bugme-daemon@bugzilla.kernel.org writes:

> http://bugzilla.kernel.org/show_bug.cgi?id=7505
>
> ------- Additional Comments From agalanin@mera.ru  2006-12-18 07:39 -------
> OK, fixed.


Greg.

It appears commit d71374dafbba7ec3f67371d3b7e9f6310a588808 which
replaced the pci bus spinlock with a semaphore causes some systems not
to boot.  I haven't a clue why.   

So I figure I would toss the ball over to your court to see if you can
look and see what needs to happen to resolve this problem.

There appears to be at least one positive confirmation that reverting
this patch allows this patch fixes the problems.

Eric






