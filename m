Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWI0Rqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWI0Rqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWI0Rqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:46:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32796 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030489AbWI0Rqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:46:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b4VII1xWz/Otra/U2GyQ7TsNfYXGCLsK2PC1PGVisjY3X3ZgDlW3FD1oNzHMqKimmHltBbNJt+jVdU+98chx47+dxNmqoXgpFoHO1zRupEt+aHz03jlEpNG1z5VfLvDO90sEQDquU07AeOqriCdbE1Oxr5J+XQnmaou2Ip3slWE=
Message-ID: <6b4e42d10609271046x216e5175g59cb42f12e067c82@mail.gmail.com>
Date: Wed, 27 Sep 2006 10:46:36 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: kernelnewbies <kernelnewbies@nl.linux.org>, linux-kernel@vger.kernel.org
Subject: HPET : timer routing setup with Legacy Routing Replacement bit set
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am working with a new bios for a server our company build. I am
confused about the routing of the timer and arch/x86_64/kernel/time.c
irq setup.

HPET specification states that if Legacy routing replacement enable
bit is set, IRQ0 should not be connected to PIN0 of IOAPIC, and IRQ0
should not generate any interrupts. But in the kernel code, timer is
hard coded to irq0 (arch/x86_64/kernel/time.c : time_init(), calls
setup_irq(0,&irq0). 0 being the irq number)

My question is, should it not be IRQ2 if HPET is enabled and Legacy
Routing Replacement bit is enbaled?

Regards,
Om.
