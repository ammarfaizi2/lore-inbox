Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283658AbRLEBN5>; Tue, 4 Dec 2001 20:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283657AbRLEBNs>; Tue, 4 Dec 2001 20:13:48 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:12561 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S283658AbRLEBNj>; Tue, 4 Dec 2001 20:13:39 -0500
Message-ID: <3C0D74B8.F3FF439@xs4all.nl>
Date: Wed, 05 Dec 2001 02:13:28 +0100
From: Roman Zippel <zippel@xs4all.nl>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: nigel@nrg.org, george anzinger <george@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <Pine.LNX.4.40.0112041321080.595-100000@cosmic.nrg.org> <1007504598.1307.30.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Robert Love wrote:

> Right, I meant just the spin_lock_irq case, which would be fine except
> for the case where:
> 
> spin_lock_irq
> spin_unlock
> restore_irq
> 
> to solve this, we need a spin_unlock_irq_on macro that didn't touch the
> preemption count.

Has someone a real example of something like this?
I'd suspect someone is trying a (questionable) micro optimization or is
holding the lock for too long anyway. Instead of adding more macros,
maybe it's better to look closely whether something needs fixing.

bye, Roman
