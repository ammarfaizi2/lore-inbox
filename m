Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUH2QGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUH2QGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUH2QGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:06:36 -0400
Received: from holomorphy.com ([207.189.100.168]:9646 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268054AbUH2QFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:05:51 -0400
Date: Sun, 29 Aug 2004 09:05:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829160542.GF5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828201435.GB25523@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004 12:56:47 -0700, William Lee Irwin III wrote:
>> These numbers are somewhat at variance with my experience in the area,
>> as I see that the internal algorithms actually dominate the runtime
>> of the /proc/ algorithms. Could you describe the processes used for the
>> benchmarks, e.g. typical /proc/$PID/status and /proc/$PID/maps for them?

On Sat, Aug 28, 2004 at 10:14:35PM +0200, Roger Luethi wrote:
> The status/maps numbers below are not only typical, but identical for
> all tasks. I'm forking off a defined number of children and then query
> their status from the parent.
> Because I was interested in delivery overhead, I built on purpose a
> benchmark without computationally expensive fields. Expensive field
> computation hurts /proc more than nproc because the latter allows you
> to have only the currently needed fields computed.

Okay, these explain some of the difference. I usually see issues with
around 10000 processes with fully populated virtual address spaces and
several hundred vmas each, varying between 200 to 1000, mostly
concentrated at somewhere just above 300.


-- wli
