Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSKDAs2>; Sun, 3 Nov 2002 19:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbSKDAs2>; Sun, 3 Nov 2002 19:48:28 -0500
Received: from holomorphy.com ([66.224.33.161]:35729 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262492AbSKDAs1>;
	Sun, 3 Nov 2002 19:48:27 -0500
Date: Sun, 3 Nov 2002 16:53:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt checks for spinlocks
Message-ID: <20021104005339.GA16347@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
References: <mailman.1036362421.16883.linux-kernel2news@redhat.com> <200211040028.gA40S8600593@devserv.devel.redhat.com> <20021104002813.GZ16347@holomorphy.com> <20021103194249.A1603@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103194249.A1603@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
>>>> (1) check that spinlocks are not taken in interrupt context without
>>>> 	interrupts disabled

At some point in the past, Pete Zaitcev wrote:
>>> Bill, why is this bad? I routinely use this technique.

From: William Lee Irwin III <wli@holomorphy.com>
>> If you receive the same interrupt on the same cpu and re-enter code
>> that does that, you will deadlock.

On Sun, Nov 03, 2002 at 07:42:49PM -0500, Pete Zaitcev wrote:
> How would that happen? I thought it was not possible to re-enter
> an interrupt, and that it was pretty fundamental for Linux.
> When did we allow it, and what are implications for architectures?

This non-reentrant stuff hurts my head. Another patch down the
toilet, I guess.


Bill
