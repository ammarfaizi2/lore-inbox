Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136168AbRDVPFS>; Sun, 22 Apr 2001 11:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136167AbRDVPFI>; Sun, 22 Apr 2001 11:05:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21258 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136168AbRDVPFA>;
	Sun, 22 Apr 2001 11:05:00 -0400
Date: Sun, 22 Apr 2001 16:04:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Francis Litterio <franl@world.std.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does the scheduler run every time jiffies is incremented?
Message-ID: <20010422160455.F20807@flint.arm.linux.org.uk>
In-Reply-To: <m31yql2di8.fsf@chantale.std.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m31yql2di8.fsf@chantale.std.com>; from franl@world.std.com on Sun, Apr 22, 2001 at 10:52:15AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 10:52:15AM -0400, Francis Litterio wrote:
> Does the scheduler run every time jiffies is incremented?

No, it runs when something needs to be rescheduled (ie, when
the current tasks need_resched element (current->need_resched) is set).
This typically happens when someone wakes up, or the task reaches the
end of its allotted quantum.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

