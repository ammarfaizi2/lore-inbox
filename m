Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUIMOac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUIMOac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUIMOaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:30:22 -0400
Received: from holomorphy.com ([207.189.100.168]:63627 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267195AbUIMO1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:27:55 -0400
Date: Mon, 13 Sep 2004 07:27:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       mingo@elte.hu, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040913142752.GC9106@holomorphy.com>
References: <1095045628.1173.637.camel@cube> <20040913074230.GW2660@holomorphy.com> <1095084688.1173.1329.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095084688.1173.1329.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 03:42, William Lee Irwin III wrote:
>> The resource tracking and locking implications of this are disturbing.
>> Would fully pseudorandom allocation be acceptable?

On Mon, Sep 13, 2004 at 10:11:29AM -0400, Albert Cahalan wrote:
> There's no point.
> LRU reduces accidents that don't involve an attacker.
> Strong crypto random can make some attacks a bit harder.
> OpenBSD does this. It doesn't work well enough to bother
> with if the implementation is problematic; there's not
> much you can do while avoiding 64-bit or 128-bit PIDs.
> Pseudorandom is 100% useless.
> Per-user PID recycling would make it much harder for
> an attacker to grab a specific PID. Perhaps the attacker
> knows that a sched_setscheduler call is coming, and he
> has a way to make the right process restart or crash.
> Normally, this lets him get SCHED_FIFO or somesuch.
> With per-user PID recycling, it would be difficult for
> him to grab the desired PID.

I'd suggest pushing for 64-bit+ pid's, then. IIRC most of the work
there is in userspace (the in-kernel part is trivial).


-- wli
