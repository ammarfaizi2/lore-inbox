Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275105AbTHRV1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275110AbTHRV0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:26:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:524
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275105AbTHRVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:25:29 -0400
Date: Mon, 18 Aug 2003 14:25:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hank Leininger <hlein@progressive-comp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030818212526.GI10320@matchmail.com>
Mail-Followup-To: Hank Leininger <hlein@progressive-comp.com>,
	linux-kernel@vger.kernel.org
References: <20030818210238.GG10320@matchmail.com> <010308181705350.18362-100000@timmy.spinoli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010308181705350.18362-100000@timmy.spinoli.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 05:18:09PM -0400, Hank Leininger wrote:
> Hm, I see Thar Filipau bringing that up specifically, and it does seem
> like something that ought to generate some logs.  (But I thought they
> should already generate oops's?  Apparently not.)  The OP seemed to be
> concerned with any SIGSEGV and SIGILL signals, not just in-kernel ones?

No, the crashes are in userspace apps, not the kernel.  But when they
crash they get sent a signal from the kernel.  That is what needs to be
logged, not the signals an app might send to itself.
