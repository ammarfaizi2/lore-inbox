Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269466AbUINTNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269466AbUINTNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269725AbUINTLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:11:40 -0400
Received: from holomorphy.com ([207.189.100.168]:52117 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269439AbUINTIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:08:02 -0400
Date: Tue, 14 Sep 2004 12:07:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914190747.GA9106@holomorphy.com>
References: <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914184517.GA2655@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:45:18PM +0200, Roger Luethi wrote:
> I suppose you are thinking of a request that lists a number of PIDs along
> with a number of field IDs. In that case yes, I agree that it makes sense
> to provide some explicit feedback to the tool once we add access control
> (before that, there is no ambiguity: a missing answer means ESRCH).
> The most common request, though, won't provide a list of pids, it will
> only provide a list of field IDs and select all processes in the system
> (NPROC_SELECT_ALL). There is no ambiguity here, either: The tool didn't
> ask for any specific process to begin with, ESRCH doesn't make sense
> here. And for a system that looks anything like /proc does today,
> fields that are capable of triggering EPERM are few and far between,
> certainly not something you are hitting unexpectedly in the fast path
> of a process monitoring tool.

Okay, so what kinds of errors are returned in this case, if any, or
(worst case) are the offending tasks completely silently dropped?


On Tue, Sep 14, 2004 at 08:45:18PM +0200, Roger Luethi wrote:
> Thanks, by the way, for all the feedback that helped me realize that
> I have so far failed to explain the design well enough. I will try to
> work on that.

Thanks; while I could in principle expend more effort to understand the
netlink code, it's likely swifter to be given such commentary.


-- wli
