Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUCEITy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 03:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUCEITy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 03:19:54 -0500
Received: from holomorphy.com ([207.189.100.168]:30731 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262244AbUCEITw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 03:19:52 -0500
Date: Fri, 5 Mar 2004 00:19:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird utmp (?) problem on 2.6.4-rc1-mm{1,2}
Message-ID: <20040305081944.GP655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org
References: <pan.2004.03.05.07.44.32.964894@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.05.07.44.32.964894@triplehelix.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 11:44:33PM -0800, Joshua Kwan wrote:
> I noticed that 2.6.4-rc1-mm[12] are not recycling ptys:
> 23:43:39 up 16:37,  5 users,  load average: 0.39, 0.30, 0.21
> USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
> joshk    tty1     -                21:45    1:58m  1:57   0.00s /bin/sh /usr/bi
> joshk    pts/22   :0.0             21:45    3:02   1.12s  1.12s ssh influx
> joshk    pts/23   :0.0             21:45    0.00s  0.02s  0.00s w
> joshk    pts/28   :0.0             22:25    1:16m  0.02s  0.02s -bash
> When I close a terminal, and open another, the pts/ should be reused,
> shouldn't it?

The behavior was changed so that pty's aren't immediately recycled.


-- wli
