Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTIWW5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTIWW5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:57:02 -0400
Received: from holomorphy.com ([66.224.33.161]:16515 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262021AbTIWW5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:57:00 -0400
Date: Tue, 23 Sep 2003 15:58:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: bug w/ threads-max, pid_max, & /proc
Message-ID: <20030923225801.GG4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1064352192.740.3063.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064352192.740.3063.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 05:23:13PM -0400, Albert Cahalan wrote:
> Plain 2.6.0-test5 is affected. (so don't blame me)
> The /proc filesystem gets really messed up when you
> create more threads than you have PID values. Yes,
> you can do this. I created 40000 threads on a system
> with pid_max of 32768 and a threads-max of 98304.
> This should not be allowed, for obvious reasons, and
> because it breaks the /proc filesystem. Doing a
> simple "/bin/ls /proc" would return 0, 1, or 2 of
> every file. Stuff like /proc/cpuinfo was affected,
> not just the process directories.

There must be a bug; the pid allocator should report exhaustion then
instead of allowing the threads to be created. ISTR testing this...


-- wli
