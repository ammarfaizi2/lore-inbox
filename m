Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTEPPyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTEPPyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:54:19 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:23965 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264471AbTEPPyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:54:18 -0400
Message-Id: <200305161605.h4GG5fGi018381@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Thu, 15 May 2003 17:14:57 PDT."
             <20030515.171457.02279102.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 16 May 2003 12:05:41 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030515.171457.02279102.davem@redhat.com>,"David S. Miller" writes
:
>There is no correlation between whether you use netdevice or not
>and whether network configuration changes should be synchronized
>using the RTNL semaphore :-)

true.  however, i think i would like to do both at once.  but it seems 
like just replacing atm_dev_lock with rtnl would probably be enough
for right now.

>Ok, I'll apply this.  But long term we really need to clean out
>the cobwebs here, use RTNL, do solid module refcounting etc.

are you referring to the other bits of linux-atm like br2684, lane,
mpoa, pppoatm or something else?
