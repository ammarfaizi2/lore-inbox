Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWKEPWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWKEPWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 10:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWKEPWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 10:22:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17587 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932695AbWKEPWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 10:22:47 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       discuss@x86-64.org, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
Date: Sun, 05 Nov 2006 08:22:20 -0700
In-Reply-To: <20061105064801.GV13381@stusta.de> (Adrian Bunk's message of
	"Sun, 5 Nov 2006 07:48:01 +0100")
Message-ID: <m1hcxdq5oz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

>
> Subject    : x86_64: NR_IRQ increase causes 11.5% slowdown
>                      in lmbench's fork benchmark
> References : http://lkml.org/lkml/2006/11/2/192
> Submitter  : Tim Chen <tim.c.chen@linux.intel.com>
> Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
>              commit 550f2299ac8ffaba943cf211380d3a8d3fa75301
> Handled-By : Eric W. Biederman <ebiederm@xmission.com>
>              Andi Kleen <ak@suse.de>
> Status     : problem is being debugged

Currently I'm at a loss why the cross cpu fork lm_bench numbers should get
worse when you simply double NR_IRQS.  As far as I can determine nothing
on that code path is directly affected by that change.

Eric
