Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130390AbRCBKef>; Fri, 2 Mar 2001 05:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRCBKeQ>; Fri, 2 Mar 2001 05:34:16 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:32772 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S130390AbRCBKeE>;
	Fri, 2 Mar 2001 05:34:04 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 2 Mar 2001 10:12:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Scott Laird <laird@internap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
Message-ID: <20010302101236.A21799@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0103011607540.17365-100000@laird.ocp.internap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103011607540.17365-100000@laird.ocp.internap.com>; from laird@internap.com on Thu, Mar 01, 2001 at 04:41:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 04:41:01PM -0800, Scott Laird wrote:
> I have a fairly repeatable rsync over ssh stall that I'm seeing between
> two Linux boxes, both running identical 2.4.1 kernels.  The stall is
> fairly easy to repeat in our environment -- it can happen up to several
> times per minute, and usually happens at least once per minute.  It
> doesn't really seem to be data-sensitive.  The stall will last until the
> session times out *unless* I take one of two steps to "unstall" it.  The
> easiest way to do this is to run 'strace -p $PID' against the sending ssh
> process.  As soon as the strace is started, rsync starts working again,
> but will stall again (even with strace still running) after a short period
> of time.
>...
> According to 'ps l', the ssh process is waiting in 'sock_wait_for_wmem'.

I've also reported this recently, and got told that it was because I was
running 2.2.15pre13 on one end.  Thanks for confirming that 2.2.15pre13
is not the cause.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

