Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285006AbRLXO2K>; Mon, 24 Dec 2001 09:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285018AbRLXO2B>; Mon, 24 Dec 2001 09:28:01 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:27921 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S285006AbRLXO15>; Mon, 24 Dec 2001 09:27:57 -0500
Date: Mon, 24 Dec 2001 06:27:48 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Total system lockup with Alt-SysRQ-L
In-Reply-To: <20011224083752.A1181@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0112240621370.26289-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001, Russell King wrote:

> The problem was definitely in the exit_notify code, where it
> manipulated the task links indefinitely.  (I think it was cptr never
> becomes null, so the loop never terminates).
>
> However, if we're saying that "pid1 must not die" then maybe we should
> get rid of the 'killall' sysrq option since it serves no useful
> purpose, and add a suitable panic in the do_exit path?
>
> I'll generate a patch for that if there's interest.

What would be even better, and I think there may already be such an
option, would be a one-button "sync up all the disks, forbid any more
writes, save as much state as possbile (registers, memory) to a swap
partition, set a flag for crash dump processing and reboot" capability.

-- 
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

If God had meant carrots to be eaten cooked, He would have given rabbits
fire.

