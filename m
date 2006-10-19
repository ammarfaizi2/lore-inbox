Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422858AbWJSJjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422858AbWJSJjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422941AbWJSJjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:39:15 -0400
Received: from poczta.o2.pl ([193.17.41.142]:11421 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1422858AbWJSJjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:39:14 -0400
Date: Thu, 19 Oct 2006 11:44:19 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Steve Rottinger <steve@pentek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 Hard lockup advice needed: do_IRQ: stack overflow 508
Message-ID: <20061019094419.GB3296@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Steve Rottinger <steve@pentek.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45364D3C.3070204@pentek.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-2006 17:50, Steve Rottinger wrote:
> Hi,
> 
> I have a small Pentium 4 file server set up using version 2.6.18 of the 
> Kernel.  The system contains a SiI 3124 based SATA controller, and I 
> have a software RAID set up, with LVM enabled.   During normal daily 
> operation, the system is stable.    However, when I perform nightly 
> backups, and there is a lot of disk and network activity, as the data is 
> transferred to a backup server, the system eventually locks up.   
> Unfortunately, there is no indication of a failure in the system logs.   
> I also enabled the NMI_Watchdog without any additional visibility.    By 
> disabling the screen blanking on the console windows,  I do get a single 
> message reported before the lockup:
> 
> do_IRQ: stack overflow 508
> do_IRQ+0x69/0xbc 0xc0104ce4
> 
> If I downgrade to 2.6.17 of the Kernel, I see the same problem, but it 
> takes longer for it to occur.

You can try to change "Use 4Kb for kernel stacks instead of 8Kb" 
setting under "Kernel hacking" and if no result enable more
debugging options.

Jarek P.
