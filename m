Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWAMNdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWAMNdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbWAMNdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:33:40 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:921 "EHLO
	orac.home") by vger.kernel.org with ESMTP id S1422664AbWAMNdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:33:39 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: speedtch driver, 2.6.14.2
Date: Fri, 13 Jan 2006 13:33:32 +0000
User-Agent: KMail/1.8.2
References: <200511232125.25254.s0348365@sms.ed.ac.uk> <200601131315.55355.duncan.sands@free.fr>
In-Reply-To: <200601131315.55355.duncan.sands@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131333.32507.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 12:15, Duncan Sands wrote:
> > I recently switched from the userspace speedtouch driver to the in-kernel
> > one. However, on my rev 4.0 Speedtouch 330, I periodically get the
> > message:
> >
> > ATM dev 0: error -110 fetching device status

Me too.

log-2005-12-08-08:39:10:Dec  5 04:34:34 [kernel] ATM dev 0: error -110 
fetching device status
log-2005-12-31-24:59:59:Dec 14 18:17:59 [kernel] ATM dev 0: error -110 
fetching device status
current:Jan 12 11:32:33 [kernel] ATM dev 0: error -110 fetching device status

So it happens every two/three weeks. I have to reboot to get the ADSL line 
back up.

>
> Is this correlated with disk activity (heavy use of the pci bus)?
>

Not here. This is an essentially idle mail server, using ADSL as backup net 
connection.

$ uptime
 13:26:09 up 17:08,  0 users,  load average: 0.01, 0.01, 0.00

$ uname -a
Linux pelagius.h-e-r-e-s-y.com 2.6.14.2 #1 SMP PREEMPT Sat Nov 12 21:01:17 GMT 
2005 i686 unknown unknown GNU/Linux

I guess people running desktops rarely notice the problem, since they are 
likely to power cycle more frequently than the error occurs. For long lived 
servers, its quite a nuisance.

Let me know if I can do anything to help track this down. I'm happy to run an 
instrumented kernel if that would help.

Andrew Walrond
