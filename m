Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129127AbRBSPX7>; Mon, 19 Feb 2001 10:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbRBSPXj>; Mon, 19 Feb 2001 10:23:39 -0500
Received: from colorfullife.com ([216.156.138.34]:62982 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129127AbRBSPXe>;
	Mon, 19 Feb 2001 10:23:34 -0500
Message-ID: <3A913A5D.FF8E1083@colorfullife.com>
Date: Mon, 19 Feb 2001 16:23:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Philipp Rumpf <prumpf@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15
In-Reply-To: <30512.982588558@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
>  wait_for_at_least_one_schedule_on_every_cpu();

what about

	spin_unlock_wait(&global_exception_lock);

The actual exception table waker uses
	spin_lock_irqsave(&global_exception_lock);

	spin_unlock_irqsave(&global_exception_lock);

Or a simple spinlock - the code shouldn't be performance critical.
--
	Manfred
