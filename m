Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbUJZLEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbUJZLEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUJZLEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:04:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36113 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262219AbUJZLEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:04:07 -0400
Date: Tue, 26 Oct 2004 12:04:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/timer.c: xtime lock missing
Message-ID: <20041026120402.B31632@flint.arm.linux.org.uk>
Mail-Followup-To: George Anzinger <george@mvista.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	john stultz <johnstul@us.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20041021190312.GA30847@kvack.org> <1098390198.20778.226.camel@cog.beaverton.ibm.com> <20041021202904.GB30847@kvack.org> <417D87BF.6060803@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <417D87BF.6060803@mvista.com>; from george@mvista.com on Mon, Oct 25, 2004 at 04:09:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 04:09:51PM -0700, George Anzinger wrote:
> If memory serves, there is a problem here in that the lock is taken in arch
> code and not all archs are taking it.  I think a check of the several arch
> time.c callers might be in order.

Certainly absolutely none of the ARM timer implementations were taking
the lock.  They do now because its rather necessary to ensure working
gettimeofday().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
