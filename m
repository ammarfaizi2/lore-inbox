Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVCHCav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVCHCav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVCHCaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:30:01 -0500
Received: from innocence.nightwish.hu ([217.20.130.196]:60044 "EHLO
	innocence.nightwish.hu") by vger.kernel.org with ESMTP
	id S261939AbVCHC1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:27:54 -0500
Subject: Re: NMI watchdog question
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Mar 2005 03:28:52 +0100
Message-Id: <1110248933.8018.229.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> On Mon, 2005-03-07 at 11:16 +0100, Mikael Pettersson wrote:
>> Please try nmi_watchdog=2.
> 
> tried, doesn't work.. much less NMI interrupts in /proc/interrupts this
> time

 although, nmi_watchdog=1 works well when this crazy module loaded

 may it be a hardware bug?  or maybe a usual thing that the low-level
drivers can put the hardware to such a situation when NMI's are stopped
or the nmi_die message can't get out?   (sorry for this newbie question
and thanks for your replies)


== nofuture.c:

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

int deadlock_init(void)
{
    local_irq_disable();
    while ("I want to loop!")
    ;

    return 0;
}

module_init(deadlock_init);



--
 d

