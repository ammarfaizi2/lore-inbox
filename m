Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbSKDBhQ>; Sun, 3 Nov 2002 20:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSKDBhQ>; Sun, 3 Nov 2002 20:37:16 -0500
Received: from holomorphy.com ([66.224.33.161]:48017 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264616AbSKDBhP>;
	Sun, 3 Nov 2002 20:37:15 -0500
Date: Sun, 3 Nov 2002 17:42:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: interrupt checks for spinlocks
Message-ID: <20021104014224.GR23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1036362421.16883.linux-kernel2news@redhat.com> <200211040028.gA40S8600593@devserv.devel.redhat.com> <20021104002813.GZ16347@holomorphy.com> <20021103194249.A1603@devserv.devel.redhat.com> <20021104005339.GA16347@holomorphy.com> <1036372685.752.7.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036372685.752.7.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 19:53, William Lee Irwin III wrote:
>> This non-reentrant stuff hurts my head. Another patch down the
>> toilet, I guess.

On Sun, Nov 03, 2002 at 08:18:04PM -0500, Robert Love wrote:
> No, I think you have a good idea.  Pete is right, though, the current
> interrupt is disabled... but normally the other interrupts are still
> enabled.
> Your ideas #2, #3, and #4 are good.
> Because once the lock is tainted, you still want to ensure process
> context disables interrupts before grabbing the lock.
> 	Robert Love

I'll go figure out why before posting a follow-up. This is not doing
what I wanted it to because the only one I originally wanted was (1),
having to do with interrupt-time recursion on rwlocks and writer
starvation caused by it.


Bill
