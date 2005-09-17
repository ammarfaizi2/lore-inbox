Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVIQB1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVIQB1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIQB1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:27:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28908 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750812AbVIQB1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:27:24 -0400
Subject: Re: NTP leap second question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: george@mvista.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
In-Reply-To: <432B6BDF.2010607@mvista.com>
References: <20050914222003.23790.qmail@science.horizon.com>
	 <432B3FEB.1070303@mvista.com>
	 <1126920192.22339.7.camel@localhost.localdomain>
	 <432B6BDF.2010607@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 17 Sep 2005 02:53:01 +0100
Message-Id: <1126921981.22531.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Eh??  Then what is one to make of the code in timer.c that add 
> leapseconds?  It seems to be controlled by the adjtime() system call.
> 
> Sure looks like it sets the system clock (xtime) ahead or back by a 
> second at midnight if the flag is set to do so.

Yes it supports that - but since nobody runs the system clock in GMT it
should never be getting set by any caller. At least as far as I can see
from the code in glibc any glibc using system should never have xntpd
set the flag

