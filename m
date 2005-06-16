Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVFPXWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVFPXWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVFPXWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:22:35 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:20484 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261854AbVFPXWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 19:22:33 -0400
Date: Fri, 17 Jun 2005 01:22:42 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Scott Bardone <sbardone@chelsio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050616232242.GR2821@mail.muni.cz>
References: <8A71B368A89016469F72CD08050AD3340255F0@maui.asicdesigners.com> <20050608184933.GC2369@mail.muni.cz> <42A742FF.2020706@chelsio.com> <20050608193215.GF2369@mail.muni.cz> <42A74F88.10502@chelsio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A74F88.10502@chelsio.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 01:05:28PM -0700, Scott Bardone wrote:
> There is one thing you could do though. If want, you could hack the TOE 
> driver to work with the latest kernel in NIC mode. You would need to 
> disable all the offload functions. Copy the source into the kernel tree, 
> then when you build it you will see the unresolved symbols. Disable those 
> sections of code, then you should end up with a NIC driver which will run 
> on the latest kernel.

I have ported your driver for kernel 2.6.6 to kernel 2.6.8 and 2.6.11.12, it
seems that it works (including TOE).

test3:~ # cat /proc/net/toe/devices 
Device           Offload Module       Interfaces
toe0             Chelsio T1           eth0
test3:~ # uname -a
Linux test3 2.6.11.12 #3 SMP Fri Jun 17 01:15:03 CEST 2005 x86_64 x86_64 x86_64
GNU/Linux
test3:~ # 

I can provide patch to mailing list if it is allowed.

-- 
Luká¹ Hejtmánek
