Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWDHUJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWDHUJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWDHUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:09:24 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:53991 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751420AbWDHUJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:09:23 -0400
Date: Sat, 8 Apr 2006 23:09:15 +0300
From: Ville Herva <vherva@vianova.fi>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
Message-ID: <20060408200915.GN1686@vianova.fi>
Reply-To: vherva@vianova.fi
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 08:47:06PM -0700, you [Linus Torvalds] wrote:
> 
> Ok, 
>  it's two weeks since 2.6.16, and the merge window is closed.

I upgraded from 2.6.15-rc7 to 2.6.17-rc1. rc1 seems nice other than that
iptables stopped working:

 failed iptables v1.3.5: can't initialize iptables table filter: iptables
 who? (do you need to insmod?) 
 Perhaps iptables or your kernel needs to be upgraded.

iptables is compiled in the kernel, not a module:
 CONFIG_NETFILTER=y

I can even do "modprobe iptable_nat" successfully (iptable_nat is module),
but iptables refuses to work. iptables is of version iptables-1.3.5-1.2. 

The kernel config is copied with make oldconfig from 2.6.15-rc7 (which
worked), not much else has changed. I just booted back to 2.6.15-rc7 and
verified it works. Any ideas?



-- v -- 

v@iki.fi

