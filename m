Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUEXBGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUEXBGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUEXBGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:06:33 -0400
Received: from holomorphy.com ([207.189.100.168]:9606 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263786AbUEXBE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:04:57 -0400
Date: Sun, 23 May 2004 18:04:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040524010455.GJ1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040524003200.14639.qmail@web90007.mail.scd.yahoo.com> <20040524005751.62303.qmail@web90006.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524005751.62303.qmail@web90006.mail.scd.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 05:57:51PM -0700, Phy Prabab wrote:
> Just for more clarification, here is a perfect
> example:
> 2.6.7-p1:
> 24.86user 51.77system 2:58.87elapsed 42%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (13major+7591686minor)pagefaults
> 0swaps
> 2.4.21:
> 28.68user 34.98system 1:12.34elapsed 87%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (5691267major+1130523minor)pagefaults
> 0swaps

Thanks. This reveals that the performance regression is system time.
Could you please rerun the 2.6.7-rc1 test with kernel profiling on,
and reset the profile buffer prior just prior to the run?

This is the kernel command line option profile=1, and then as root,
echo 1 > /proc/profile just prior to the run.


-- wli
