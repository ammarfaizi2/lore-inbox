Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTD2M67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTD2M67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:58:59 -0400
Received: from p50888CD3.dip0.t-ipconnect.de ([80.136.140.211]:60685 "EHLO
	gw.sphinx-it.de") by vger.kernel.org with ESMTP id S261876AbTD2M66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:58:58 -0400
Message-ID: <3EAE7A11.3040603@coolgoose.com>
Date: Tue, 29 Apr 2003 15:11:45 +0200
From: Schwarzseher <fields35@coolgoose.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3b) Gecko/20030313 Minotaur/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.68: SMP for arch/sparc broken?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm currently trying to get linux running on my old (but it's my own :-) 
Tatung SparcStation 20 clone, mainly for acting as a dsl-router / 
firewall. Kind of exotic I guess, but funny. I must confess that I'm 
pretty new to linux on sparc while running linux on i386 for nearly 8 years.

The device has two processors (high speed 85MHz). I installed a debian 
distro and now trying to bring it on actual (or rather bleeding edge) 
software revisions.

While trying to compile a 2.5.68 kernel I stumbled into a problem: the 
function "cpu_possible":
while being defined for other architectures in include/asm-i386/smp.h or 
similar it is missing in include/asm-sparc/smp.h.
Unfortunately it seems to be needed to successfully compile a kernel 
because several other things depend on it. Also unfortunately I don't 
have the slightest idea on how to fix it because I'm not that deep in 
the sparc system architecture (or the linux kernel architecture).

Any suggestions (besides to stay with a (successfully for SMP compiled) 
2.4.20 kernel)?

Regards
Schwarzseher

P.S.: When already at the topic, now offtopic for this list: any ideas 
on why swapon /dev/sdc2 throws a core since I updated the kernel to 
2.4.20? The swapon systemcall is called and the swapspace is added but 
afterwards the swapon utility makes a segfault.

