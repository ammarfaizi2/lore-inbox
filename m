Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUEBItV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUEBItV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUEBItV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:49:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12810 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262905AbUEBItU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:49:20 -0400
Date: Sun, 2 May 2004 10:48:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH][2.4] remove amd7(saucy)_tco
Message-ID: <20040502084841.GA10228@alpha.home.local>
References: <Pine.LNX.4.58.0405011534230.2332@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405011534230.2332@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 03:37:36PM -0400, Zwane Mwaikambo wrote:
> Hello Marcelo,
> 	This driver has already been removed in 2.6, essentially we've had
> problems getting it working (it's been a while now) with a lot of boards,
> all seems to be alright until the actual point where the hardware is
> supposed to reset the system. So lets just back it out.

Indeed, I've just checked here, because I believed I had seen it working,
but now I think it was the softdog. It does nothing at all. I've downloaded
and read AMD's datasheet and the driver seems to do the right thing. BTW,
I wonder if the chip is buggy or not, because I tried to play with the
SYSRST and FULLRST bits in the 0xCF9 register. Changing SYSRST to 1 does not
change anything, and changing FULLRST to 1 immediately reboots the machine
even if no reset was pending !

Regards,
Willy

